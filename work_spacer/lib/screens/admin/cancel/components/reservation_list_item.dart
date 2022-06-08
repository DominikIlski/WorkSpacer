import 'package:flutter/material.dart';
import 'package:work_spacer/models/desk_reservation.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/models/room_reservation.dart';
import 'package:intl/intl.dart';

class ReservationListItem extends StatelessWidget {
  final Reservation reservation;
  final VoidCallback onCancel;

  const ReservationListItem({
    super.key,
    required this.reservation,
    required this.onCancel,
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
        size: 36,
      );
      title = 'Desk #${(reservation as DeskReservation).desk.id}';
    } else {
      leadingColor = Theme.of(context).secondaryHeaderColor;
      iconColor = leadingColor;
      icon = Icon(
        Icons.meeting_room_outlined,
        color: iconColor,
        size: 36,
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                const SizedBox(height: 16),
                Row(children: [
                  Icon(Icons.calendar_month_outlined, color: iconColor),
                  const SizedBox(width: 6),
                  Text(
                    DateFormat('dd.MM.yyyy').format(reservation.startDate),
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  Icon(Icons.timer_outlined, color: iconColor),
                  const SizedBox(width: 6),
                  Text(
                    DateFormat.jm().format(reservation.startDate),
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  Icon(Icons.hourglass_empty, color: iconColor),
                  const SizedBox(width: 6),
                  Text(
                    '${reservation.duration} hours',
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                ]),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.red,
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
              child: const Text('Cancel'),
              onPressed: onCancel,
            ),
          ],
        ),
      ),
    );
  }
}
