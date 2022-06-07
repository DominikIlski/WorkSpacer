import 'package:flutter/material.dart';
import 'package:work_spacer/models/workspace.dart';

import '../../../../models/desk.dart';
import '../../../../models/room.dart';

class GridItem extends StatelessWidget {
  const GridItem({
    super.key,
    required this.workspace,
    required this.onItemClicked,
  });

  final Workspace workspace;
  final VoidCallback onItemClicked;

  @override
  Widget build(BuildContext context) {
    var data;
    Color? leadingColor;
    Color? iconColor;
    Icon? icon;

    if (workspace is Desk) {
      data = workspace as Desk;
      leadingColor = Theme.of(context).primaryColorDark;
      iconColor = Theme.of(context).primaryColor;
      icon = Icon(
        Icons.desktop_windows_outlined,
        color: iconColor,
        size: 45,
      );
    } else if (workspace is Room) {
      data = workspace as Room;
      leadingColor = Theme.of(context).secondaryHeaderColor;
      iconColor = leadingColor;
      icon = Icon(
        Icons.meeting_room_outlined,
        color: iconColor,
        size: 45,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(2),
      child: GestureDetector(
        onTap: onItemClicked,
        child: Card(
          color: Theme.of(context).primaryColorLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: leadingColor!,
              width: 1.5,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  icon!,
                  const SizedBox(height: 10),
                  Text(
                    "#${data.id}",
                    style: TextStyle(
                      color: leadingColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}