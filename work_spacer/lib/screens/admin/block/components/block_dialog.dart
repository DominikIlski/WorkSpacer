import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/screens/admin/block/components/date_picker_tile.dart';

class BlockDialog extends StatefulWidget {
  const BlockDialog({
    Key? key,
    required this.workspace,
    required this.onBlock,
  }) : super(key: key);

  final Workspace workspace;
  final Function(Workspace workspace) onBlock;

  @override
  State<BlockDialog> createState() => _BlockDialogState();
}

class _BlockDialogState extends State<BlockDialog> {
  DateTime? _startDate, _endDate;
  String _startDateText = 'Select start date', _endDateText = 'Select end date';

  void _setStartDate(DateTime? date) {
    if (date == null) {
      return;
    }
    setState(() {
      _startDate = date;
      _startDateText = DateFormat('dd.MM.yyyy').format(_startDate!);
      if (_endDate?.compareTo(_startDate!) == -1) {
        _endDate = null;
        _endDateText = 'Select end date';
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

  void _startDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((start) => _setStartDate(start));
  }

  void _endDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime.now(),
      lastDate: _startDate?.add(const Duration(days: 365)) ??
          DateTime.now().add(const Duration(days: 365)),
    ).then((end) => _setEndDate(end));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter duration'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DatePickerTile(
            hintText: _startDateText,
            onTap: _startDatePicker,
          ),
          const SizedBox(height: 16),
          DatePickerTile(
            hintText: _endDateText,
            onTap: _endDatePicker,
          ),
          if (_startDate == null || _endDate == null)
            const SizedBox(height: 16),
          if (_startDate == null || _endDate == null)
            Text(
              'Dates must be selected!',
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 14,
              ),
            ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
          ),
        ),
        ElevatedButton(
          onPressed: _startDate == null || _endDate == null
              ? null
              : () {
                  widget.onBlock(widget.workspace);
                  Navigator.pop(context);
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(
                  Icons.block,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'Block',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
