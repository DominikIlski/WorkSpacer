import 'package:flutter/material.dart';

class EmployeeReservationsScreen extends StatelessWidget {
  static const routeName = '/my_reservations';

  const EmployeeReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My reservations'),
      ),
      body: Container(),
    );
  }
}
