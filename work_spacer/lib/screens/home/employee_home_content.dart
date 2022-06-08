import 'package:flutter/material.dart';
import 'package:work_spacer/screens/employee/desks/desk_search_screen.dart';
import 'package:work_spacer/screens/employee/reservations/employee_reservations_screen.dart';
import 'package:work_spacer/screens/employee/rooms/room_search_screen.dart';
import 'components/home_screen_button.dart';

class EmployeeHomeContent extends StatelessWidget {
  const EmployeeHomeContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HomeScreenButton(
            title: "My reservations",
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                EmployeeReservationsScreen.routeName,
              );
            },
            icon: Icons.event_available_rounded,
            backgroundColor: Colors.deepOrange.shade200,
            contentColor: Colors.white,
          ),
          const SizedBox(height: 32),
          HomeScreenButton(
            title: "Desks",
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                DeskSearchScreen.routeName,
              );
            },
            icon: Icons.desktop_windows_outlined,
            backgroundColor: Colors.teal.shade300,
            contentColor: Colors.teal.shade900,
          ),
          const SizedBox(height: 32),
          HomeScreenButton(
            title: "Conference rooms",
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                RoomSearchScreen.routeName,
              );
            },
            icon: Icons.meeting_room_outlined,
            backgroundColor: Colors.teal.shade300,
            contentColor: Colors.teal.shade900,
          ),
        ],
      ),
    );
  }
}
