import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:work_spacer/screens/admin/block/workspace_block_screen.dart';
import 'package:work_spacer/screens/admin/cancel/reservation_cancel_screen.dart';
import 'package:work_spacer/screens/admin/roles/role_management_screen.dart';
import 'package:work_spacer/screens/employee/desks/desk_search_screen.dart';
import 'package:work_spacer/screens/employee/notifications/notifications_screen.dart';
import 'package:work_spacer/screens/employee/reservations/employee_reservations_screen.dart';
import 'package:work_spacer/screens/employee/rooms/room_search_screen.dart';
import 'package:work_spacer/screens/home/home_screen.dart';
import 'package:work_spacer/screens/login/login_screen.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(
            primarySwatch: Colors.teal,
            primaryColorDark: Color(0xFF006D77),
            primaryColor: Color(0xFF83C5BE),
            primaryColorLight: Color(0xFFEDF6F9),
            secondaryHeaderColor: Color(0xFFE29578),
            dialogBackgroundColor: Color(0xFFEDF6F9),
            accentColor: Color(0xFFFFDDD2),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          //Define an initial route based on login status.
          //TODO initialRoute: userLoggedIn ? HomeView.routeName : LoginView.routeName
          initialRoute: LoginScreen.routeName,
          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case LoginScreen.routeName:
                    return const LoginScreen();
                  case HomeScreen.routeName:
                    return const HomeScreen();
                  case NotificationsScreen.routeName:
                    return const NotificationsScreen();
                  case EmployeeReservationsScreen.routeName:
                    return const EmployeeReservationsScreen();
                  case DeskSearchScreen.routeName:
                    return const DeskSearchScreen();
                  case RoomSearchScreen.routeName:
                    return const RoomSearchScreen();
                  case ReservationCancelScreen.routeName:
                    return ReservationCancelScreen();
                  case WorkspaceBlockScreen.routeName:
                    return const WorkspaceBlockScreen();
                  case RoleManagementScreen.routeName:
                    return const RoleManagementScreen();
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SampleItemListView.routeName:
                    return const SampleItemListView();
                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();
                  default:
                    return const LoginScreen();
                }
              },
            );
          },
        );
      },
    );
  }
}
