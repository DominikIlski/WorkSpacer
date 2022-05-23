import 'package:flutter/material.dart';

class WorkspaceBlockScreen extends StatelessWidget {
  static const routeName = '/block';

  const WorkspaceBlockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Block a workspace'),
      ),
      body: Container(),
    );
  }
}
