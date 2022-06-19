import 'package:flutter/material.dart';
import 'package:work_spacer/i18n.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/room.dart';
import 'package:work_spacer/models/workspace.dart';

class WorkspaceDetailsList extends StatelessWidget {
  const WorkspaceDetailsList({Key? key, required this.workspace})
      : super(key: key);

  final Workspace workspace;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: _getContent(context),
    );
  }

  List<Widget> _getContent(context) {
    if (workspace is Desk) {
      final desk = workspace as Desk;
      return [
        _getRow(context, translate.floor, '${desk.floor}'),
        const SizedBox(height: 8),
        _getRow(context, translate.monitor,
            desk.secondMonitor ? translate.yes : translate.no),
      ];
    } else {
      final room = workspace as Room;
      return [
        _getRow(context, translate.floor, '${room.floor}'),
        const SizedBox(height: 8),
        _getRow(context, translate.capacity, '${room.capacity}'),
        const SizedBox(height: 8),
        _getRow(context, translate.whiteboard,
            room.whiteboard ? translate.yes : translate.no),
        const SizedBox(height: 8),
        _getRow(context, translate.projector,
            room.projector ? translate.yes : translate.no),
        const SizedBox(height: 8),
        _getRow(context, translate.teleconf,
            room.teleconferenceSystem ? translate.yes : translate.no),
      ];
    }
  }

  _getRow(context, String title, String value) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$title: ',
          style: theme.textTheme.subtitle1,
        ),
        Text(
          value,
          style: theme.textTheme.subtitle1?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
