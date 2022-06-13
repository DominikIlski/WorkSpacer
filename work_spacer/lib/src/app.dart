import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/i18n.dart';
import 'package:work_spacer/screens/admin/block/workspace_block_screen.dart';
import 'package:work_spacer/screens/admin/cancel/reservation_cancel_screen.dart';
import 'package:work_spacer/screens/admin/roles/role_management_screen.dart';
import 'package:work_spacer/screens/employee/desks/desk_search_screen.dart';
import 'package:work_spacer/screens/employee/notifications/notifications_screen.dart';
import 'package:work_spacer/screens/employee/reservations/employee_reservations_screen.dart';
import 'package:work_spacer/screens/employee/rooms/room_search_screen.dart';
import 'package:work_spacer/screens/home/home_screen.dart';
import 'package:work_spacer/screens/login/login_screen.dart';
import 'package:work_spacer/stores/authentication_store.dart';
import 'package:work_spacer/stores/block_store.dart';
import 'package:work_spacer/stores/cancel_store.dart';
import 'package:work_spacer/stores/desks_store.dart';
import 'package:work_spacer/stores/notification_store.dart';
import 'package:work_spacer/stores/reservation_store.dart';
import 'package:work_spacer/stores/role_management_store.dart';
import 'package:work_spacer/stores/rooms_store.dart';
import 'package:work_spacer/theme.dart';
import 'settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
          providers: [
            Provider<AuthenticationStore>(
              create: (context) => AuthenticationStore(),
            ),
            Provider<CancelStore>(create: (context) => CancelStore()),
            Provider<BlockStore>(create: (context) => BlockStore()),
            Provider<ReservationStore>(create: (context) => ReservationStore()),
            Provider<DesksStore>(create: (context) => DesksStore()),
            Provider<RoomsStore>(create: (context) => RoomsStore()),
            Provider<NotificationStore>(
                create: (context) => NotificationStore()),
            Provider<RoleManagementStore>(
                create: (context) => RoleManagementStore()),
          ],
          child: MaterialApp(
            restorationScopeId: 'app',
            localizationsDelegates: const [
              ...AppLocalizations.localizationsDelegates,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            onGenerateTitle: (BuildContext context) {
              translate = AppLocalizations.of(context)!;
              return translate.appTitle;
            },
            theme: prepareLightTheme(),
            darkTheme: prepareDarkTheme(),
            themeMode: settingsController.themeMode,
            initialRoute: LoginScreen.routeName,
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case LoginScreen.routeName:
                      return const LoginScreen();
                    case HomeScreen.routeName:
                      return HomeScreen(settingsController: settingsController);
                    case NotificationsScreen.routeName:
                      return const NotificationsScreen();
                    case EmployeeReservationsScreen.routeName:
                      return const EmployeeReservationsScreen();
                    case DeskSearchScreen.routeName:
                      return const DeskSearchScreen();
                    case RoomSearchScreen.routeName:
                      return const RoomSearchScreen();
                    case ReservationCancelScreen.routeName:
                      return const ReservationCancelScreen();
                    case WorkspaceBlockScreen.routeName:
                      return const WorkspaceBlockScreen();
                    case RoleManagementScreen.routeName:
                      return const RoleManagementScreen();
                    default:
                      return const LoginScreen();
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
