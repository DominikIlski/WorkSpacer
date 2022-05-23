import 'package:flutter/material.dart';
import 'package:work_spacer/screens/admin/block/workspace_block_screen.dart';
import 'package:work_spacer/screens/admin/cancel/reservation_cancel_screen.dart';
import 'package:work_spacer/screens/admin/roles/role_management_screen.dart';

class AdminHomeContent extends StatelessWidget {
  const AdminHomeContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.free_cancellation_rounded,
              color: Colors.blue,
            ),
            title: const Text('Cancel a reservation'),
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                ReservationCancelScreen.routeName,
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.block_rounded,
              color: Colors.blue,
            ),
            title: const Text('Block a workspace'),
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                WorkspaceBlockScreen.routeName,
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.lock_outline_rounded,
              color: Colors.blue,
            ),
            title: const Text('Manage roles'),
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                RoleManagementScreen.routeName,
              );
            },
          ),
        ),
      ],
    );
  }
}
