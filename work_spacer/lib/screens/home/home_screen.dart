import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/screens/employee/notifications/notifications_screen.dart';
import 'package:work_spacer/screens/home/admin_home_content.dart';
import 'package:work_spacer/screens/home/employee_home_content.dart';
import 'package:work_spacer/screens/login/login_screen.dart';
import 'package:work_spacer/src/settings/settings_view.dart';
import 'package:work_spacer/stores/authentication_store.dart';
import 'package:work_spacer/stores/notification_store.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthenticationStore>(context);
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(translate.company),
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

  _handleLogout(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(translate.pleaseConfirm),
        content: const Text(translate.logOutQ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(translate.cancel),
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
              translate.confirm,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
