import 'package:flutter/material.dart';
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
        _getRow(context, 'Floor', '${desk.floor}'),
        const SizedBox(height: 8),
        _getRow(context, 'Second monitor', desk.secondMonitor ? 'Yes' : 'No'),
      ];
    } else {
      final room = workspace as Room;
      return [
        _getRow(context, 'Floor', '${room.floor}'),
        const SizedBox(height: 8),
        _getRow(context, 'Capacity', '${room.capacity}'),
        const SizedBox(height: 8),
        _getRow(context, 'Whiteboard', room.hasWhiteboard ? 'Yes' : 'No'),
        const SizedBox(height: 8),
        _getRow(context, 'Projector', room.hasProjector ? 'Yes' : 'No'),
        const SizedBox(height: 8),
        _getRow(context, 'Teleconference system',
            room.hasTeleconference ? 'Yes' : 'No'),
      ];
    }
  }

  _getRow(context, String title, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$title: '),
        Text(value,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ))
      ],
    );
  }
}
