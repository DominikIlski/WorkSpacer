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
    final theme = Theme.of(context);

    String title;
    Icon? icon;

    if (reservation is DeskReservation) {
      icon = Icon(
        Icons.desktop_windows,
        color: theme.colorScheme.tertiary,
        size: 36,
      );
      title = 'Desk #${(reservation as DeskReservation).desk.id}';
    } else {
      icon = Icon(
        Icons.meeting_room_outlined,
        color: theme.colorScheme.tertiary,
        size: 36,
      );
      title = 'Room #${(reservation as RoomReservation).room.id}';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.headline6,
                ),
                const SizedBox(height: 12),
                _getIconText(
                  theme,
                  Icons.calendar_month_outlined,
                  DateFormat('dd.MM.yyyy').format(reservation.startDate),
                ),
                if (!showDateOnly) const SizedBox(height: 8),
                if (!showDateOnly)
                  _getIconText(
                    theme,
                    Icons.timer_outlined,
                    DateFormat.jm().format(reservation.startDate),
                  ),
                if (!showDateOnly) const SizedBox(height: 8),
                if (!showDateOnly)
                  _getIconText(
                    theme,
                    Icons.hourglass_empty,
                    '${reservation.duration} hours',
                  ),
              ],
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: onCancel,
              label: const Text('Cancel'),
              icon: const Icon(Icons.delete_outline_rounded),
            ),
          ],
        ),
      ),
    );
  }

  _getIconText(ThemeData theme, IconData iconData, String text) {
    return Row(
      children: [
        Icon(
          iconData,
          color: theme.colorScheme.tertiary,
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: theme.textTheme.bodyText1,
        ),
      ],
    );
  }
}
