import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FilterableWorkspaceList extends StatelessWidget {
  const FilterableWorkspaceList({
    super.key,
    required this.observerFilterButtons,
    required this.child,
  });

  final List<Observer> observerFilterButtons;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 32,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: observerFilterButtons
                .map((button) => Center(child: button))
                .toList(),
          ),
        ),
        const SizedBox(height: 16),
        Divider(
          height: 0,
          thickness: 1,
          color: Theme.of(context).secondaryHeaderColor,
        ),
        const SizedBox(height: 12),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
