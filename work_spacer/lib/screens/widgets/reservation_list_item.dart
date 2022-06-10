import 'package:flutter/material.dart';
import 'package:work_spacer/models/desk_reservation.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/models/room_reservation.dart';
import 'package:intl/intl.dart';

class ReservationListItem extends StatelessWidget {
  final Reservation reservation;
  final VoidCallback onCancel;
  final bool showDateOnly;

  const ReservationListItem({
    super.key,
    required this.reservation,
    required this.onCancel,
    this.showDateOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    String title;
    Icon? icon;
    Color? leadingColor;
    Color? iconColor;

    if (reservation is DeskReservation) {
      leadingColor = Theme.of(context).primaryColorDark;
      iconColor = Theme.of(context).primaryColor;
      icon = Icon(
        Icons.desktop_windows,
        color: iconColor,
        size: 28,
      );
      title = 'Desk #${(reservation as DeskReservation).desk.id}';
    } else {
      leadingColor = Theme.of(context).secondaryHeaderColor;
      iconColor = leadingColor;
      icon = Icon(
        Icons.meeting_room_outlined,
        color: iconColor,
        size: 28,
      );
      title = 'Room #${(reservation as RoomReservation).room.id}';
    }

    return Card(
      color: Theme.of(context).primaryColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(
          color: leadingColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: leadingColor,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 12),
                _getIconText(
                  context,
                  Icons.calendar_month_outlined,
                  iconColor,
                  DateFormat('dd.MM.yyyy').format(reservation.startDate),
                ),
                if (!showDateOnly) const SizedBox(height: 8),
                if (!showDateOnly)
                  _getIconText(
                    context,
                    Icons.timer_outlined,
                    iconColor,
                    DateFormat.jm().format(reservation.startDate),
                  ),
                if (!showDateOnly) const SizedBox(height: 8),
                if (!showDateOnly)
                  _getIconText(
                    context,
                    Icons.hourglass_empty,
                    iconColor,
                    '${reservation.duration} hours',
                  ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).secondaryHeaderColor,
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
              child: Row(
                children: const [
                  Icon(Icons.delete_outline_rounded),
                  SizedBox(width: 4),
                  Text('Cancel'),
                ],
              ),
              onPressed: onCancel,
            ),
          ],
        ),
      ),
    );
  }

  _getIconText(context, IconData iconData, Color iconColor, String text) {
    return Row(
      children: [
        Icon(iconData, color: iconColor),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
      ],
    );
  }
}
