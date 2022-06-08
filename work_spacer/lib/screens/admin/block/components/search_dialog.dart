import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_spacer/misc/keyboard_hide_wrapper.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/screens/admin/block/components/date_picker_tile.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({
    Key? key,
    required this.filter,
    required this.onConfirm,
    required this.onReset,
    this.initialText,
  }) : super(key: key);

  final FilterParameter filter;
  final Function(FilterParameter parameter, String valueAsString) onConfirm;
  final Function(FilterParameter parameter) onReset;
  final String? initialText;

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final _controller = TextEditingController();
  DateTime? _date;
  String _dateText = 'Select date';

  @override
  void initState() {
    super.initState();
    final filterDataType = filterParameterDataTypes[widget.filter];
    if (widget.initialText != null) {
      setState(() {
        if (filterDataType == FilterDataType.number) {
          _controller.text = widget.initialText!;
        }
        if (filterDataType == FilterDataType.date) {
          _setDate(DateTime.tryParse(widget.initialText!));
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterDataType = filterParameterDataTypes[widget.filter];
    return KeyboardHideWrapper(
      child: AlertDialog(
        title: Text(
          'Enter the value',
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (filterDataType == FilterDataType.number)
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  hintText: filterParameterNames[widget.filter] ?? '',
                ),
                keyboardType: TextInputType.number,
              ),
            if (filterDataType == FilterDataType.date)
              DatePickerTile(
                hintText: _dateText,
                onTap: _datePicker,
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              widget.onReset(widget.filter);
              Navigator.pop(context);
            },
            child: const Text('Reset'),
          ),
          TextButton(
            onPressed: () {
              if (filterDataType == FilterDataType.number) {
                widget.onConfirm(widget.filter, _controller.text);
              }
              if (filterDataType == FilterDataType.date) {
                widget.onConfirm(widget.filter, _dateText);
              }
              Navigator.pop(context);
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
      ),
    );
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((date) => _setDate(date));
  }

  void _setDate(DateTime? date) {
    if (date == null) {
      return;
    }
    setState(() {
      _date = date;
      _dateText = DateFormat('dd.MM.yyyy').format(_date!);
    });
  }
}
