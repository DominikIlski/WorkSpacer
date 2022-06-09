import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/screens/employee/desks/desk_search_screen.dart';
import 'package:work_spacer/screens/employee/reservations/employee_reservations_screen.dart';
import 'package:work_spacer/screens/employee/rooms/room_search_screen.dart';
import 'package:work_spacer/stores/desks_store.dart';
import 'package:work_spacer/stores/reservation_store.dart';
import 'package:work_spacer/stores/rooms_store.dart';
import 'components/home_screen_button.dart';

class EmployeeHomeContent extends StatelessWidget {
  const EmployeeHomeContent({super.key});

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
              final store =
                  Provider.of<ReservationStore>(context, listen: false);
              store.fetchReservations();
              Navigator.restorablePushNamed(
                context,
                EmployeeReservationsScreen.routeName,
              );
            },
            icon: Icons.event_available_rounded,
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            contentColor: Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(height: 32),
          HomeScreenButton(
            title: "Desks",
            onTap: () {
              final store = Provider.of<DesksStore>(context, listen: false);
              store.fetchDesks();
              Navigator.restorablePushNamed(
                context,
                DeskSearchScreen.routeName,
              );
            },
            icon: Icons.desktop_windows_outlined,
            backgroundColor: Theme.of(context).primaryColor,
            contentColor: Theme.of(context).primaryColorDark,
          ),
          const SizedBox(height: 32),
          HomeScreenButton(
            title: "Conference rooms",
            onTap: () {
              final store = Provider.of<RoomsStore>(context, listen: false);
              store.fetchRooms();
              Navigator.restorablePushNamed(
                context,
                RoomSearchScreen.routeName,
              );
            },
            icon: Icons.meeting_room_outlined,
            backgroundColor: Theme.of(context).primaryColor,
            contentColor: Theme.of(context).primaryColorDark,
          ),
        ],
      ),
    );
  }
}
