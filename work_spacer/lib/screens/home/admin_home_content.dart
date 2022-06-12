import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/screens/admin/block/workspace_block_screen.dart';
import 'package:work_spacer/screens/admin/cancel/reservation_cancel_screen.dart';
import 'package:work_spacer/screens/admin/roles/role_management_screen.dart';
import 'package:work_spacer/stores/block_store.dart';
import 'package:work_spacer/stores/cancel_store.dart';
import 'package:work_spacer/stores/role_management_store.dart';
import 'home_screen_button.dart';

class AdminHomeContent extends StatelessWidget {
  const AdminHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HomeScreenButton(
          title: translate.cancelRes,
          onTap: () {
            Provider.of<CancelStore>(context, listen: false)
                .fetchReservations();
            Navigator.restorablePushNamed(
              context,
              ReservationCancelScreen.routeName,
            );
          },
          icon: Icons.free_cancellation_rounded,
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          contentColor: Theme.of(context).colorScheme.onPrimary,
        ),
        const SizedBox(height: 32),
        HomeScreenButton(
          title: translate.blockWS,
          onTap: () {
            final store = Provider.of<BlockStore>(context, listen: false);
            store.fetchDesks();
            store.fetchRooms();
            Navigator.restorablePushNamed(
              context,
              WorkspaceBlockScreen.routeName,
            );
          },
          icon: Icons.block,
          backgroundColor: Theme.of(context).primaryColorLight,
          contentColor: Theme.of(context).secondaryHeaderColor,
          hasBorder: true,
        ),
        const SizedBox(height: 32),
        HomeScreenButton(
          title: translate.manageRoles,
          onTap: () {
            final store =
                Provider.of<RoleManagementStore>(context, listen: false);
            store.fetchUsers();
            Navigator.restorablePushNamed(
              context,
              RoleManagementScreen.routeName,
            );
          },
          icon: Icons.lock_outline,
          backgroundColor: Theme.of(context).primaryColor,
          contentColor: Theme.of(context).primaryColorDark,
        ),
      ],
    );
  }
}
