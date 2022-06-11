import 'package:flutter/material.dart';

class KeyboardHideWrapper extends StatelessWidget {
  final Widget child;

  const KeyboardHideWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
