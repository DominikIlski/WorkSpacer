import 'package:flutter/material.dart';
import 'package:work_spacer/screens/widgets/keyboard_hide_wrapper.dart';
import 'package:work_spacer/screens/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return KeyboardHideWrapper(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.workspaces_rounded,
                    size: 40,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Company XYZ',
                      style: textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Welcome.',
                      style: textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const LoginForm(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
