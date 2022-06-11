import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/workspace.dart';

class WorkspaceGrid extends StatelessWidget {
  const WorkspaceGrid({
    Key? key,
    required this.workspaces,
    required this.onTap,
  }) : super(key: key);

  final List<Workspace> workspaces;
  final Function(Workspace) onTap;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => GridView.builder(
        itemCount: workspaces.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) => _GridItem(
          workspace: workspaces[index],
          onTap: () => onTap.call(workspaces[index]),
        ),
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({
    Key? key,
    required this.workspace,
    required this.onTap,
  }) : super(key: key);

  final Workspace workspace;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color? leadingColor;
    Color? iconColor;
    Icon? icon;

    if (workspace is Desk) {
      leadingColor = Theme.of(context).primaryColorDark;
      iconColor = Theme.of(context).primaryColor;
      icon = Icon(
        Icons.desktop_windows_outlined,
        color: iconColor,
        size: 40,
      );
    } else {
      leadingColor = Theme.of(context).secondaryHeaderColor;
      iconColor = leadingColor;
      icon = Icon(
        Icons.meeting_room_outlined,
        color: iconColor,
        size: 40,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        color: Theme.of(context).primaryColorLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: leadingColor),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(height: 8),
                Text(
                  "#${workspace.id}",
                  style: TextStyle(color: leadingColor, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
