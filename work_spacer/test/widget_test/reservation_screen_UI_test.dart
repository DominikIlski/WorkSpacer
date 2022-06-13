// This is an example Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
//
// Visit https://flutter.dev/docs/cookbook/testing/widget/introduction for
// more information about Widget testing.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:work_spacer/screens/home/admin_home_content.dart';
import 'package:work_spacer/screens/home/home_screen_button.dart';
import 'package:work_spacer/screens/login/login_form.dart';
import 'package:work_spacer/src/app.dart';
import 'package:work_spacer/src/settings/settings_controller.dart';
import 'package:work_spacer/src/settings/settings_service.dart';

void main() {
  group('Registration UI Test', () {
    testWidgets('Should display Login Screen', (WidgetTester tester) async {
      // Define a Widget
      final settingsController = SettingsController(SettingsService());
      await settingsController.loadSettings();

      // Build myWidget and trigger a frame.
      await tester.pumpWidget(MyApp(settingsController: settingsController));

      Finder loginInputsFinder = find.byType(TextFormField);

      expect(loginInputsFinder, findsNWidgets(2));

      Finder loginInputField = find.byKey(Key('login_form_field'));
      Finder passwordInputField = find.byKey(Key('password_form_field'));
      Finder loginBtn = find.byKey(Key('login_btn'));

      expect(loginInputField, findsOneWidget);
      expect(passwordInputField, findsOneWidget);
      expect(loginBtn, findsOneWidget);

    });
  });
}
