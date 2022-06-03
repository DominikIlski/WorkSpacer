import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/screens/admin/block/components/date_picker_tile.dart';


class BlockDialog extends StatefulWidget {
  BlockDialog({
    Key? key,
    required this.workspace,
    required this.onBlockClicked,
  }) : super(key: key);

  final Workspace workspace;
  final Function(DateTime? start, DateTime? end, Workspace workspace) onBlockClicked;

  @override
  State<BlockDialog> createState() => _BlockDialogState();
}

class _BlockDialogState extends State<BlockDialog> {
  DateTime? _endDate = null;
  DateTime? _startDate = null;

  String _endDateText = "End...";
  String _startDateText = "Begin...";

  void _setStartDate(DateTime? date) {
    if (date == null) {
      return;
    }
    setState(() {
      _startDate = date;
      _startDateText = DateFormat('dd.MM.yyyy').format(_startDate!);
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
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    ).then((start) => _setStartDate(start));
  }

  void _endDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    ).then((end) => _setEndDate(end));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter duration',
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
          )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DatePickerTile(
            hintText: _startDateText,
            onClicked: _startDatePicker,
          ),
          SizedBox(height: 16),
          DatePickerTile(
            hintText: _endDateText,
            onClicked: _endDatePicker,
          ),
          SizedBox(height: 16),
          RaisedButton(
            onPressed: () {
              widget.onBlockClicked(
                _startDate,
                _endDate,
                widget.workspace,
              );
              Navigator.pop(context, 'confirm');
            },
            color: Theme.of(context).secondaryHeaderColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.all(6),
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
      ),
    );
  }
}
