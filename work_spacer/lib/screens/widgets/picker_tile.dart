import 'package:flutter/material.dart';

enum PickerType { date, time }

class PickerTile extends StatelessWidget {
  const PickerTile({
    Key? key,
    required this.hintText,
    required this.onTap,
    required this.pickerType,
  }) : super(key: key);

  final String hintText;
  final VoidCallback onTap;
  final PickerType pickerType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                pickerType == PickerType.date
                    ? Icons.calendar_month_outlined
                    : Icons.timer_outlined,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  hintText,
                  style: theme.textTheme.bodyText1
                      ?.copyWith(color: theme.colorScheme.primary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
