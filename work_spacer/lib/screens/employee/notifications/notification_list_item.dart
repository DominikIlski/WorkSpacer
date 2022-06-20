import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:work_spacer/i18n.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/notification.dart' as custom;
import 'package:work_spacer/models/room.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/screens/widgets/make_reservation_dialog.dart';
import 'package:work_spacer/screens/widgets/rounded_button.dart';

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
    final theme = Theme.of(context);
    final backgroundColor = notification.isNew
        ? theme.listTileTheme.selectedTileColor
        : theme.listTileTheme.tileColor;
    final foregroundColor = notification.isNew
        ? theme.listTileTheme.selectedColor
        : theme.listTileTheme.textColor;

    return Observer(
      builder: (context) => Card(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                notification.isNew
                    ? Icons.notifications_active_outlined
                    : Icons.notifications_outlined,
                color: foregroundColor,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${translate.reservation} #${notification.reservation.id} ${translate.cancelled}!',
                      style: theme.textTheme.headline6?.copyWith(
                        color: foregroundColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _getDetails(
                      theme.textTheme.bodyText1
                          ?.copyWith(color: foregroundColor),
                      foregroundColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      translate.replacements,
                      style: theme.textTheme.subtitle1?.copyWith(
                        color: foregroundColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (notification.replacements.isEmpty)
                      Text(
                        translate.noReplacements,
                        style: theme.textTheme.bodyText1?.copyWith(
                          color: foregroundColor,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (notification.replacements.isNotEmpty)
                      SizedBox(
                        height: 40,
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

  _getDetails(TextStyle? textStyle, Color? foregroundColor) {
    return Row(
      children: [
        _getIconText(
          textStyle,
          foregroundColor,
          Icons.calendar_month_outlined,
          DateFormat('dd.MM.yyyy').format(notification.reservation.startDate),
        ),
        const SizedBox(width: 16),
        _getIconText(
          textStyle,
          foregroundColor,
          Icons.timer_outlined,
          DateFormat.jm().format(notification.reservation.startDate),
        ),
        const SizedBox(width: 16),
        _getIconText(
          textStyle,
          foregroundColor,
          Icons.hourglass_empty,
          '${notification.reservation.duration} ${translate.hours}',
        ),
      ],
    );
  }

  _getIconText(TextStyle? textStyle, Color? foregroundColor, IconData iconData,
      String text) {
    return Row(
      children: [
        Icon(iconData, color: foregroundColor, size: 20),
        const SizedBox(width: 2),
        Text(
          text,
          style: textStyle,
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
