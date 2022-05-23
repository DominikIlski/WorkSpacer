import 'package:flutter/material.dart';

class DeskSearchScreen extends StatelessWidget {
  static const routeName = '/desks';

  const DeskSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desks'),
      ),
      body: Container(),
    );
  }
}
