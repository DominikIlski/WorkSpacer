import 'package:flutter/material.dart';

class RoleManagementScreen extends StatelessWidget {
  static const routeName = '/roles';

  const RoleManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage roles'),
      ),
      body: Container(),
    );
  }
}
