import 'package:flutter/material.dart';

class HomeScreenButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const HomeScreenButton({
    super.key,
    required this.icon,
    required this.title,
    this.selected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        selected: selected,
        leading: Icon(
          icon,
          color: selected
              ? theme.listTileTheme.selectedColor
              : theme.listTileTheme.iconColor,
          size: 32,
        ),
        title: Text(
          title,
          style: theme.textTheme.headline6?.copyWith(
              color: selected
                  ? theme.listTileTheme.selectedColor
                  : theme.listTileTheme.textColor),
        ),
        onTap: onTap,
      ),
    );
  }
}
