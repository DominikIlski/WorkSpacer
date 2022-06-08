import 'package:flutter/material.dart';

class DatePickerTile extends StatelessWidget {
  const DatePickerTile({
    Key? key,
    required this.hintText,
    required this.onTap,
  }) : super(key: key);

  final String hintText;
  final VoidCallback onTap;

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
                Icons.calendar_month_outlined,
                color: Theme.of(context).primaryColorDark,
              ),
              const SizedBox(width: 8),
              Text(
                hintText,
                style: TextStyle(
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
