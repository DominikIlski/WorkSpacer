import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/screens/employee/notifications/notifications_screen.dart';
import 'package:work_spacer/screens/home/admin_home_content.dart';
import 'package:work_spacer/screens/home/employee_home_content.dart';
import 'package:work_spacer/screens/login/login_screen.dart';
import 'package:work_spacer/src/settings/settings_controller.dart';
import 'package:work_spacer/stores/authentication_store.dart';
import 'package:work_spacer/stores/notification_store.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthenticationStore>(context);
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [
              Icon(
                Icons.image,
                color: Colors.amber,
                size: 32,
              ),
              SizedBox(width: 12),
              Text('Company XYZ'),
            ],
          ),
          actions: _getActions(context, authStore.isAdmin),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: authStore.isAdmin
              ? const AdminHomeContent()
              : const EmployeeHomeContent(),
        ),
      ),
    );
  }

  List<Widget>? _getActions(context, bool isAdmin) {
    return [
      if (!isAdmin)
        IconButton(
          onPressed: () {
            Provider.of<NotificationStore>(context, listen: false)
                .fetchNotifications();
            Navigator.pushNamed(
              context,
              NotificationsScreen.routeName,
            ).then(
              (_) => Provider.of<NotificationStore>(context, listen: false)
                  .readNotifications(),
            );
          },
          icon: const Icon(Icons.notifications_active_outlined),
        ),
      IconButton(
        onPressed: () {
          if (settingsController.themeMode == ThemeMode.system) {
            settingsController.updateThemeMode(ThemeMode.light);
          } else if (settingsController.themeMode == ThemeMode.light) {
            settingsController.updateThemeMode(ThemeMode.dark);
          } else {
            settingsController.updateThemeMode(ThemeMode.system);
          }
        },
        icon: Icon(settingsController.themeMode == ThemeMode.system
            ? Icons.brightness_auto_outlined
            : settingsController.themeMode == ThemeMode.light
                ? Icons.light_mode
                : Icons.dark_mode),
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
            onPressed: () {
              Provider.of<AuthenticationStore>(context, listen: false).logOut();
              Navigator.pop(context);
              Navigator.restorablePushReplacementNamed(
                context,
                LoginScreen.routeName,
              );
            },
            child: const Text(
              'Confirm',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
