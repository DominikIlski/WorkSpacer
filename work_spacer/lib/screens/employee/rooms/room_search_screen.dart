import 'package:flutter/material.dart';

class RoomSearchScreen extends StatelessWidget {
  static const routeName = '/rooms';

  const RoomSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms'),
      ),
      body: Container(),
    );
  }
}
