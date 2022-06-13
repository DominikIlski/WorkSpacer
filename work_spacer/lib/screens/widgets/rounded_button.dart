import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.title,
    this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool? isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: theme.colorScheme.primary),
          ),
          color: isSelected == null
              ? theme.cardTheme.color
              : isSelected!
                  ? theme.colorScheme.primary
                  : theme.colorScheme.background,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected == null
                      ? theme.colorScheme.primary
                      : isSelected!
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
