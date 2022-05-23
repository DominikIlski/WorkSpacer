import 'package:flutter/material.dart';
import 'package:work_spacer/screens/employee/notifications/notifications_screen.dart';
import 'package:work_spacer/screens/home/admin_home_content.dart';
import 'package:work_spacer/screens/home/employee_home_content.dart';
import 'package:work_spacer/screens/login/login_screen.dart';
import 'package:work_spacer/src/settings/settings_view.dart';

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
      if (!isAdmin)
        IconButton(
          icon: const Icon(Icons.notifications_rounded),
          onPressed: () {
            Navigator.restorablePushNamed(
              context,
              NotificationsScreen.routeName,
            );
          },
        ),
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          // Navigate to the settings page. If the user leaves and returns
          // to the app after it has been killed while running in the
          // background, the navigation stack is restored.
          Navigator.restorablePushNamed(context, SettingsView.routeName);
        },
      ),
      IconButton(
        icon: const Icon(Icons.logout_rounded),
        onPressed: () => _handleLogout(context),
      ),
    ];
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
