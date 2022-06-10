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
    return Card(
      color: Theme.of(context).primaryColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: Theme.of(context).primaryColorDark),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                pickerType == PickerType.date
                    ? Icons.calendar_month_outlined
                    : Icons.timer_outlined,
                color: Theme.of(context).primaryColorDark,
              ),
              const SizedBox(width: 8),
              Text(
                hintText,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
