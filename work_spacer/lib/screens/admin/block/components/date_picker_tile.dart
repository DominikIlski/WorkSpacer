import 'package:flutter/material.dart';

class DatePickerTile extends StatelessWidget {
  const DatePickerTile({
    Key? key,
    required this.hintText,
    required this.onClicked,
  }) : super(key: key);

  final String hintText;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).primaryColorLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Theme.of(context).primaryColorDark,
            width: 1.5,
          ),
        ),
        child: ListTile(
          leading: Icon(
            Icons.calendar_month_outlined,
            color: Theme.of(context).primaryColorDark,
          ),
          title: Text(
            hintText,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          onTap: onClicked,
        ));
  }
}
