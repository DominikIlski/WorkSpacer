import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:work_spacer/i18n.dart';
import 'package:work_spacer/screens/widgets/keyboard_hide_wrapper.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/screens/widgets/picker_tile.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({
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
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final _controller = TextEditingController();
  DateTime? _date;
  String _dateText = translate.selectDate;
  TimeOfDay? _time;
  String _timeText = translate.selectHour;

  @override
  void initState() {
    super.initState();
    final filterDataType = filterParameterDataTypes[widget.filter];
    if (widget.initialText != null) {
      setState(() {
        if (filterDataType == FilterDataType.number ||
            filterDataType == FilterDataType.text) {
          _controller.text = widget.initialText!;
        }
        if (filterDataType == FilterDataType.date) {
          try {
            _setDate(DateFormat('dd.MM.yyyy').parse(widget.initialText!));
          } catch (e) {
            //ignore
          }
        }
        if (filterDataType == FilterDataType.time) {
          try {
            final dateTime = DateFormat.jm().parse(widget.initialText!);
            _setTime(
              TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
            );
          } catch (e) {
            //ignore
          }
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
    return UnfocusWrapper(
      child: AlertDialog(
        title: Text(translate.enterValue),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (filterDataType == FilterDataType.number ||
                filterDataType == FilterDataType.text)
              TextField(
                controller: _controller,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: filterParameterNames[widget.filter] ?? '',
                ),
                keyboardType: filterDataType == FilterDataType.number
                    ? const TextInputType.numberWithOptions()
                    : TextInputType.text,
                inputFormatters: filterDataType == FilterDataType.number
                    ? [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))]
                    : null,
              ),
            if (filterDataType == FilterDataType.date)
              PickerTile(
                pickerType: PickerType.date,
                hintText: _dateText,
                onTap: _datePicker,
              ),
            if (filterDataType == FilterDataType.time)
              PickerTile(
                pickerType: PickerType.time,
                hintText: _timeText,
                onTap: _timePicker,
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.onReset(widget.filter);
              Navigator.pop(context);
            },
            child: Text(
              translate.reset,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(translate.cancel),
          ),
          TextButton(
            onPressed: () {
              if (filterDataType == FilterDataType.number ||
                  filterDataType == FilterDataType.text) {
                widget.onConfirm(widget.filter, _controller.text);
              }
              if (filterDataType == FilterDataType.date) {
                widget.onConfirm(widget.filter, _dateText);
              }
              if (filterDataType == FilterDataType.time) {
                widget.onConfirm(widget.filter, _timeText);
              }
              Navigator.pop(context);
            },
            child: Text(
              translate.confirm,
              style: const TextStyle(fontWeight: FontWeight.bold),
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
      confirmText: translate.confirm,
      cancelText: translate.cancel,
    ).then((date) => _setDate(date));
  }

  void _timePicker() {
    showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
      confirmText: translate.confirm,
      cancelText: translate.cancel,
    ).then((time) => _setTime(time));
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

  void _setTime(TimeOfDay? time) {
    if (time == null) {
      return;
    }
    setState(() {
      final now = DateTime.now();
      _time = time;
      _timeText = DateFormat.jm().format(
        DateTime(now.year, now.month, now.day, time.hour, time.minute),
      );
    });
  }
}
