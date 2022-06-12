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
              contentPadding: EdgeInsets.zero,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.login_rounded),
              hintText: translate.login,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            validator: (value) =>
                value == null || value.isEmpty ? translate.enterPassword : null,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.key_rounded),
              hintText: translate.password,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loginProcessor,
            child: Text(translate.login),
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
