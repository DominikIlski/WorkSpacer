import 'package:flutter/material.dart';

class KeyboardHideWrapper extends StatelessWidget {
  final Widget child;

  const KeyboardHideWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: child,
    );
  }
}
