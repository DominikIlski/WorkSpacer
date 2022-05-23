import 'package:flutter/material.dart';

class ReservationCancelScreen extends StatelessWidget {
  static const routeName = '/cancel';

  const ReservationCancelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cancel a reservation'),
      ),
      body: Container(),
    );
  }
}
