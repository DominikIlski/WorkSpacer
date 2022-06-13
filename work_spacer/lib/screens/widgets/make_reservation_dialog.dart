import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/i18n.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/screens/widgets/number_selector.dart';
import 'package:work_spacer/screens/widgets/picker_tile.dart';
import 'package:work_spacer/screens/widgets/workspace_details_list.dart';
import 'package:work_spacer/stores/authentication_store.dart';

class MakeReservationDialog extends StatefulWidget {
  const MakeReservationDialog({
    Key? key,
    required this.workspace,
    required this.onConfirm,
  }) : super(key: key);

  final Workspace workspace;
  final Function(int? userId, Workspace workspace, DateTime date,
      TimeOfDay time, int hours) onConfirm;

  @override
  State<MakeReservationDialog> createState() => _MakeReservationDialogState();
}

class _MakeReservationDialogState extends State<MakeReservationDialog> {
  DateTime? _date;
  String _dateText = translate.selectDate;
  TimeOfDay? _time;
  String _timeText = translate.selectHour;
  int _hours = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      title: Row(
        children: [
          Icon(
            Icons.desktop_windows_outlined,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Text(
              '${widget.workspace is Desk ? translate.desk : translate.room} #${widget.workspace.id}'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 4),
            child: WorkspaceDetailsList(workspace: widget.workspace),
          ),
          const SizedBox(height: 16),
          PickerTile(
            pickerType: PickerType.date,
            hintText: _dateText,
            onTap: _datePicker,
          ),
          PickerTile(
            pickerType: PickerType.time,
            hintText: _timeText,
            onTap: _timePicker,
          ),
          const SizedBox(height: 8),
          Text(
            translate.selectDuration,
            style: theme.textTheme.subtitle1,
          ),
          NumberSelector(
            value: _hours,
            onIncrement: () {
              setState(() {
                _hours++;
              });
            },
            onDecrement: () {
              setState(() {
                _hours--;
              });
            },
          ),
          if (_date == null || _time == null) const SizedBox(height: 16),
          if (_date == null || _time == null)
            Text(
              translate.specifyDateTimeError,
              style: TextStyle(
                color: theme.colorScheme.error,
                fontSize: 14,
              ),
            ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(translate.cancel),
        ),
        TextButton(
          onPressed: _date == null || _time == null
              ? null
              : () {
                  final authStore =
                      Provider.of<AuthenticationStore>(context, listen: false);
                  widget.onConfirm(authStore.userId, widget.workspace, _date!,
                      _time!, _hours);
                  Navigator.pop(context);
                },
          child: Text(
            translate.makeRes,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
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
