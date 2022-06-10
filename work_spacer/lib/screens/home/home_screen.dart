import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/screens/employee/notifications/notifications_screen.dart';
import 'package:work_spacer/screens/home/admin_home_content.dart';
import 'package:work_spacer/screens/home/employee_home_content.dart';
import 'package:work_spacer/screens/login/login_screen.dart';
import 'package:work_spacer/src/settings/settings_view.dart';
import 'package:work_spacer/stores/notification_store.dart';

//TODO implement distinguishing between user and admin when logging in
const isAdmin = true;

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company XYZ'),
        actions: _getActions(context),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: isAdmin ? AdminHomeContent() : EmployeeHomeContent(),
      ),
    );
  }

  List<Widget>? _getActions(context) {
    return [
      if (!isAdmin) _getNotificationsButton(context),
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          Navigator.restorablePushNamed(context, SettingsView.routeName);
        },
      ),
      IconButton(
        icon: const Icon(Icons.logout_rounded),
        onPressed: () => _handleLogout(context),
      ),
    ];
  }

  Widget _getNotificationsButton(context) {
    final notifications = Provider.of<NotificationStore>(context);
    return IconButton(
      icon: Observer(builder: (_) {
        final newNotificationsLength = notifications.notifications
            .where((notification) => notification.isNew)
            .length;
        if (newNotificationsLength > 0) {
          return Stack(
            children: [
              const Icon(Icons.notifications_active_outlined),
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    '$newNotificationsLength',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Icon(Icons.notifications_active_outlined);
        }
      }),
      onPressed: () {
        Navigator.pushNamed(
          context,
          NotificationsScreen.routeName,
        ).then(
          (_) => notifications.readNotifications(),
        );
      },
    );
  }

  _handleLogout(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Please confirm'),
        content: const Text('Do you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'confirm'),
            child: const Text(
              'Confirm',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ).then((result) {
      if (result == 'confirm') {
        //TODO perform logout
        Navigator.restorablePushReplacementNamed(
          context,
          LoginScreen.routeName,
        );
      }
    });
  }
}
