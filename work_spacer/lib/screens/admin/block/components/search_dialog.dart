import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchDialog extends StatelessWidget {
  SearchDialog({
    Key? key,
    required this.parameter,
    required this.onConfirm,
  }) : super(key: key);

  final String parameter;
  final Function(int searchParameter) onConfirm;
  TextEditingController parameterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter $parameter',
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
          )),
      content: TextField(
        controller: parameterController,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          hintText: "$parameter...",
          focusColor: Theme.of(context).secondaryHeaderColor,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'cancel'),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            onConfirm(int.parse(parameterController.text));
            Navigator.pop(context, 'confirm');
          },
          child: Text(
            'Confirm',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ),
      ],
    );
  }
}
