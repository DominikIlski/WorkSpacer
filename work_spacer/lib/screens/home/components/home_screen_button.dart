import 'package:flutter/material.dart';

import '../../admin/cancel/reservation_cancel_screen.dart';

class HomeScreenButton extends StatelessWidget {
  final Color backgroundColor;
  final Color contentColor;
  final String title;
  final IconData icon;
  final String navRouteName;
  final bool hasBorder;

  const HomeScreenButton(
      {super.key,
      required this.backgroundColor,
      required this.contentColor,
      required this.icon,
      required this.title,
      required this.navRouteName,
      this.hasBorder = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: hasBorder
            ? BorderSide(
                color: contentColor,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        child: ListTile(
          leading: Icon(
            icon,
            color: contentColor,
            size: 28,
          ),
          title: Text(
            title,
            style: TextStyle(color: contentColor, fontSize: 20),
          ),
          onTap: () {
            Navigator.restorablePushNamed(
              context,
              navRouteName,
            );
          },
        ),
      ),
    );
  }
}
