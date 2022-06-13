import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter your login.'
                : null,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.login_rounded),
              labelText: 'Login',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter your password.'
                : null,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.key_rounded),
              labelText: 'Password',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loginProcessor,
            child: const Text('Login'),
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
