import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/screens/home/home_screen.dart';
import 'package:work_spacer/screens/widgets/keyboard_hide_wrapper.dart';
import 'package:work_spacer/screens/login/login_form.dart';
import 'package:work_spacer/stores/authentication_store.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authStore = Provider.of<AuthenticationStore>(context);
    return UnfocusWrapper(
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
                  const Icon(
                    Icons.image,
                    size: 64,
                    color: Colors.amber,
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Company XYZ',
                      style: theme.textTheme.headline6,
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
                      style: theme.textTheme.headline6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Observer(
                    builder: (context) => authStore.inProgress
                        ? const CircularProgressIndicator()
                        : const LoginForm(),
                  ),
                  _LoginSuccessfulReaction(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginSuccessfulReaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthenticationStore>(context);
    return ReactionBuilder(
      builder: (context) => reaction((_) => authStore.userId, (int? userId) {
        if (userId != null) {
          Navigator.restorablePushReplacementNamed(
            context,
            HomeScreen.routeName,
          );
        }
      }),
      child: const SizedBox.shrink(),
    );
  }
}
