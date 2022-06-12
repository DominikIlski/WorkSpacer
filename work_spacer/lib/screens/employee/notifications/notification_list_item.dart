import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/notification.dart' as custom;
import 'package:work_spacer/models/room.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/screens/widgets/rounded_button.dart';
import 'package:work_spacer/screens/widgets/make_reservation_dialog.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    Key? key,
    required this.notification,
    required this.onReplacementConfirm,
  }) : super(key: key);

  final custom.Notification notification;
  final Function(int? userId, Workspace workspace, DateTime date,
      TimeOfDay time, int hours) onReplacementConfirm;

  @override
  Widget build(BuildContext context) {
    final leadingColor = Theme.of(context).secondaryHeaderColor;
    return Observer(
      builder: (context) => Card(
        color:
            notification.isNew ? Theme.of(context).colorScheme.secondary : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: leadingColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.notifications_active_outlined, color: leadingColor),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${translate.reservation} #${notification.reservation.id} ${translate.cancelled}',
                      style: TextStyle(
                        color: leadingColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _getDetails(context, leadingColor),
                    const SizedBox(height: 16),
                    Text(
                      translate.replacements,
                      style: TextStyle(color: leadingColor),
                    ),
                    const SizedBox(height: 6),
                    if (notification.replacements.isEmpty)
                      Text(
                        translate.noReplacements,
                        style: TextStyle(
                          color: leadingColor,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (notification.replacements.isNotEmpty)
                      SizedBox(
                        height: 32,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: notification.replacements.map(
                            (workspace) {
                              String text;
                              if (workspace is Desk) {
                                text = translate.desk;
                              } else {
                                text = translate.room;
                              }
                              return RoundedButton(
                                title: '$text #${workspace.id}',
                                onTap: () {
                                  _showReservationDialog(
                                    context,
                                    workspace,
                                  );
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getDetails(context, leadingColor) {
    return Row(
      children: [
        _getIconText(
          context,
          leadingColor,
          Icons.calendar_month_outlined,
          DateFormat('dd.MM.yyyy').format(notification.reservation.startDate),
        ),
        const SizedBox(width: 16),
        _getIconText(
          context,
          leadingColor,
          Icons.timer_outlined,
          DateFormat.jm().format(notification.reservation.startDate),
        ),
        const SizedBox(width: 16),
        _getIconText(
          context,
          leadingColor,
          Icons.hourglass_empty,
          '${notification.reservation.duration} ${translate.hours}',
        ),
      ],
    );
  }

  _getIconText(context, Color leadingColor, IconData iconData, String text) {
    return Row(
      children: [
        Icon(iconData, color: leadingColor, size: 20),
        const SizedBox(width: 2),
        Text(
          text,
          style: TextStyle(color: leadingColor),
        ),
      ],
    );
  }

  void _showReservationDialog(context, workspace) {
    showDialog(
      context: context,
      builder: (context) => MakeReservationDialog(
        workspace: workspace is Desk ? workspace : workspace as Room,
        onConfirm: onReplacementConfirm,
      ),
    );
  }
}
