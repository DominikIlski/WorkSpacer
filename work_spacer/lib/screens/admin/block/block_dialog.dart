import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_spacer/i18n.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/screens/widgets/picker_tile.dart';

class BlockDialog extends StatefulWidget {
  const BlockDialog({
    Key? key,
    required this.workspace,
    required this.onBlock,
  }) : super(key: key);

  final Workspace workspace;
  final Function(Workspace workspace, DateTime startDate, DateTime endDate)
      onBlock;

  @override
  State<BlockDialog> createState() => _BlockDialogState();
}

class _BlockDialogState extends State<BlockDialog> {
  DateTime? _startDate, _endDate;
  String _startDateText = translate.selectStartDate,
      _endDateText = translate.selectEndDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      title: Text(translate.enterDuration),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PickerTile(
            pickerType: PickerType.date,
            hintText: _startDateText,
            onTap: _startDatePicker,
          ),
          const SizedBox(height: 16),
          PickerTile(
            pickerType: PickerType.date,
            hintText: _endDateText,
            onTap: _endDatePicker,
          ),
          const SizedBox(height: 16),
          if (_startDate == null || _endDate == null)
            Text(
              translate.specifyDateTimeError,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 14,
              ),
            ),
          if (_startDate == null || _endDate == null) const SizedBox(height: 8),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(translate.cancel),
        ),
        ElevatedButton.icon(
          onPressed: _startDate == null || _endDate == null
              ? null
              : () {
                  widget.onBlock(widget.workspace, _startDate!, _endDate!);
                  Navigator.pop(context);
                },
          label: Text(translate.block),
          icon: const Icon(Icons.block),
        ),
      ],
    );
  }

  void _startDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      confirmText: translate.confirm,
      cancelText: translate.cancel,
    ).then((start) => _setStartDate(start));
  }

  void _endDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime.now(),
      lastDate: _startDate?.add(const Duration(days: 365)) ??
          DateTime.now().add(const Duration(days: 365)),
      confirmText: translate.confirm,
      cancelText: translate.cancel,
    ).then((end) => _setEndDate(end));
  }

  void _setStartDate(DateTime? date) {
    if (date == null) {
      return;
    }
    setState(() {
      _startDate = date;
      _startDateText = DateFormat('dd.MM.yyyy').format(_startDate!);
      if (_endDate?.compareTo(_startDate!) == -1) {
        _endDate = null;
        _endDateText = translate.selectEndDate;
      }
    });
  }

  void _setEndDate(DateTime? date) {
    if (date == null) {
      return;
    }
    setState(() {
      _endDate = date;
      _endDateText = DateFormat('dd.MM.yyyy').format(_endDate!);
    });
  }
}
