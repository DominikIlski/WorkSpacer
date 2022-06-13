import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/i18n.dart';
import 'package:work_spacer/stores/authentication_store.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: loginController,
            validator: (value) =>
                value == null || value.isEmpty ? translate.enterLogin : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.login_rounded),
              labelText: translate.login,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            validator: (value) =>
                value == null || value.isEmpty ? translate.enterPassword : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.key_rounded),
              labelText: translate.password,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loginProcessor,
            child: Text(translate.login),
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }

  _loginProcessor() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      Provider.of<AuthenticationStore>(context, listen: false).logIn();
    }
  }
}
