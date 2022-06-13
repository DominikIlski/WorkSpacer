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
      builder: (_) => workspaces.isNotEmpty
          ? GridView.builder(
              itemCount: workspaces.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) => _GridItem(
                workspace: workspaces[index],
                onTap: () => onTap.call(workspaces[index]),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search_off, size: 40),
                const SizedBox(height: 8),
                Text(
                  'No available workspaces.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
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
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  workspace is Desk
                      ? Icons.desktop_windows_outlined
                      : Icons.meeting_room_outlined,
                  color: theme.colorScheme.tertiary,
                  size: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  "#${workspace.id}",
                  style: theme.textTheme.subtitle1?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
