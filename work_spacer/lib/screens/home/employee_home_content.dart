import 'package:flutter/material.dart';
import 'package:work_spacer/screens/employee/desks/desk_search_screen.dart';
import 'package:work_spacer/screens/employee/reservations/employee_reservations_screen.dart';
import 'package:work_spacer/screens/employee/rooms/room_search_screen.dart';

class EmployeeHomeContent extends StatelessWidget {
  const EmployeeHomeContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.event_available_rounded,
              color: Colors.blue,
            ),
            title: const Text(
              'My reservations',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                EmployeeReservationsScreen.routeName,
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.desktop_windows_rounded,
              color: Colors.blue,
            ),
            title: const Text('Desks'),
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                DeskSearchScreen.routeName,
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.meeting_room_rounded,
              color: Colors.blue,
            ),
            title: const Text('Rooms'),
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                RoomSearchScreen.routeName,
              );
            },
          ),
        ),
      ],
    );
  }
}
