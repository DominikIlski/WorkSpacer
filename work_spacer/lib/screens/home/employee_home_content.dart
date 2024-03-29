import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/i18n.dart';
import 'package:work_spacer/screens/employee/desks/desk_search_screen.dart';
import 'package:work_spacer/screens/employee/reservations/employee_reservations_screen.dart';
import 'package:work_spacer/screens/employee/rooms/room_search_screen.dart';
import 'package:work_spacer/stores/authentication_store.dart';
import 'package:work_spacer/stores/desks_store.dart';
import 'package:work_spacer/stores/reservation_store.dart';
import 'package:work_spacer/stores/rooms_store.dart';
import 'home_screen_button.dart';

class EmployeeHomeContent extends StatelessWidget {
  const EmployeeHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        HomeScreenButton(
          title: translate.myRes,
          selected: true,
          onTap: () {
            final store = Provider.of<ReservationStore>(context, listen: false);
            final user = Provider.of<AuthenticationStore>(context, listen: false);

            store.fetchReservations(user.userId!);
            Navigator.restorablePushNamed(
              context,
              EmployeeReservationsScreen.routeName,
            );
          },
          icon: Icons.event_available_rounded,
        ),
        const SizedBox(height: 32),
        HomeScreenButton(
          title: translate.desks,
          onTap: () {
            final store = Provider.of<DesksStore>(context, listen: false);
            store.fetchDesks();
            Navigator.restorablePushNamed(
              context,
              DeskSearchScreen.routeName,
            );
          },
          icon: Icons.desktop_windows_outlined,
        ),
        const SizedBox(height: 32),
        HomeScreenButton(
          title: translate.confRooms,
          onTap: () {
            final store = Provider.of<RoomsStore>(context, listen: false);
            store.fetchRooms();
            Navigator.restorablePushNamed(
              context,
              RoomSearchScreen.routeName,
            );
          },
          icon: Icons.meeting_room_outlined,
        ),
      ],
    );
  }
}
