import 'package:flutter/material.dart';

class HomeScreenButton extends StatelessWidget {
  final Color backgroundColor;
  final Color contentColor;
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool hasBorder;

  const HomeScreenButton({
    super.key,
    required this.backgroundColor,
    required this.contentColor,
    required this.icon,
    required this.title,
    required this.onTap,
    this.hasBorder = false,
  });

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
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        leading: Icon(
          icon,
          color: contentColor,
          size: 28,
        ),
        title: Text(
          title,
          style: TextStyle(color: contentColor, fontSize: 20),
        ),
        onTap: onTap,
      ),
    );
  }
}
