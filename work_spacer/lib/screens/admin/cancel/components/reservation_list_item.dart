import 'package:flutter/material.dart';
import 'package:work_spacer/models/desk_reservation.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/models/room_reservation.dart';
import 'package:intl/intl.dart';

class ReservationListItem extends StatelessWidget {
  Reservation reservation;
  VoidCallback onCancelClicked;

  ReservationListItem({super.key, required this.reservation, required this.onCancelClicked});

  @override
  Widget build(BuildContext context) {
    String title = "";
    Icon? icon = null;
    Color? leadingColor = null;
    Color? iconColor = null;

    if (reservation is DeskReservation) {
      leadingColor = Theme.of(context).primaryColorDark;
      iconColor = Theme.of(context).primaryColor;
      icon = Icon(
        Icons.desktop_windows,
        color: iconColor,
        size: 32,
      );
      title = "Desk #${(reservation as DeskReservation).desk.id}";
    } else if (reservation is RoomReservation) {
      leadingColor = Theme.of(context).secondaryHeaderColor;
      iconColor = leadingColor;
      icon = Icon(
        Icons.meeting_room_outlined,
        color: iconColor,
        size: 32,
      );
      title = "Room #${(reservation as RoomReservation).room.id}";
    }

    return Card(
      elevation: 0,
      color: Theme.of(context).primaryColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(
          color: leadingColor!,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon!,
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
                SizedBox(height: 8),
                Row(children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: iconColor,
                    size: 20,
                  ),
                  SizedBox(width: 4),
                  Text(
                    DateFormat('dd.MM.yyyy').format(reservation.startDate),
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                ]),
                SizedBox(height: 4),
                Row(children: [
                  Icon(
                    Icons.timer_outlined,
                    color: iconColor,
                    size: 20,
                  ),
                  SizedBox(width: 4),
                  Text(
                    DateFormat.Hm().format(reservation.startDate),
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                ]),
                SizedBox(height: 4),
                Row(children: [
                  Icon(
                    Icons.hourglass_empty,
                    color: iconColor,
                    size: 20,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${reservation.duration} hours",
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                ]),
              ],
            ),
            RaisedButton(
              color: Theme.of(context).secondaryHeaderColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.all(6),
              child: Row(
                children: const [
                  Icon(
                    Icons.delete_outline_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              onPressed: onCancelClicked,
            ),
          ],
        ),
      ),
    );
  }
}
