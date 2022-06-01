import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          backgroundColor: Colors.deepOrange.shade200,
          contentColor: Colors.white,
          icon: Icons.event_available_rounded,
          title: "My reservations",
          navRouteName: EmployeeReservationsScreen.routeName,
        ),
        const SizedBox(height: 32),
        HomeScreenButton(
          backgroundColor: Colors.teal.shade300,
          contentColor: Colors.teal.shade900,
          icon: Icons.desktop_windows_outlined,
          title: "Desks",
          navRouteName: DeskSearchScreen.routeName,
        ),
        const SizedBox(height: 32),
        HomeScreenButton(
          backgroundColor: Colors.teal.shade300,
          contentColor: Colors.teal.shade900,
          icon: Icons.meeting_room_outlined,
          title: "Conference rooms",
          navRouteName: RoomSearchScreen.routeName,
        ),
      ]),
    );
  }
}
