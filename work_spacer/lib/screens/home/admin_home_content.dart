import 'package:flutter/material.dart';
import 'package:work_spacer/screens/admin/block/workspace_block_screen.dart';
import 'package:work_spacer/screens/admin/cancel/reservation_cancel_screen.dart';
import 'package:work_spacer/screens/admin/roles/role_management_screen.dart';
import './components/home_screen_button.dart';

class AdminHomeContent extends StatelessWidget {
  const AdminHomeContent({
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
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            contentColor: Theme.of(context).colorScheme.onPrimary,
            icon: Icons.free_cancellation_rounded,
            title: 'Cancel a reservation',
            navRouteName: ReservationCancelScreen.routeName,
          ),
          const SizedBox(height: 32),
          HomeScreenButton(
            backgroundColor: Theme.of(context).primaryColorLight,
            contentColor: Theme.of(context).secondaryHeaderColor,
            icon: Icons.block,
            title: "Block a workspace",
            navRouteName: WorkspaceBlockScreen.routeName,
            hasBorder: true,
          ),
          const SizedBox(height: 32),
          HomeScreenButton(
            backgroundColor: Theme.of(context).primaryColor,
            contentColor: Theme.of(context).primaryColorDark,
            icon: Icons.lock_outline,
            title: "Manage roles",
            navRouteName: RoleManagementScreen.routeName,
          ),
        ],
      ),
    );
  }
}
