import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/screens/admin/block/components/workspace_grid.dart';
import 'package:work_spacer/screens/widgets/make_reservation_dialog.dart';
import 'package:work_spacer/screens/widgets/rounded_button.dart';
import 'package:work_spacer/screens/widgets/filterable_workspace_list.dart';
import 'package:work_spacer/screens/widgets/filter_dialog.dart';
import 'package:work_spacer/stores/desks_store.dart';

class DeskSearchScreen extends StatelessWidget {
  static const routeName = '/desks';

  const DeskSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final desksStore = Provider.of<DesksStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Desks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilterableWorkspaceList(
          observerFilterButtons: _getObserverFilterButtons(desksStore),
          child: _getContent(context, desksStore),
        ),
      ),
    );
  }

  List<Observer> _getObserverFilterButtons(DesksStore desksStore) {
    return [
      Observer(
        builder: (context) => RoundedButton(
          title: filterParameterNames[FilterParameter.floor] ?? '',
          isSelected:
              desksStore.filterStore.filters[FilterParameter.floor] != null,
          onTap: () => _showFilterDialog(
            context,
            FilterParameter.floor,
            desksStore.filterStore.toggleValueFilter,
            desksStore.filterStore.resetFilter,
            desksStore.filterStore.filters[FilterParameter.floor]?.toString(),
          ),
        ),
      ),
      Observer(
        builder: (context) => RoundedButton(
          title: filterParameterNames[FilterParameter.date] ?? '',
          isSelected:
              desksStore.filterStore.filters[FilterParameter.date] != null,
          onTap: () {
            DateTime? value =
                desksStore.filterStore.filters[FilterParameter.date];
            String? valueAsString =
                value == null ? null : DateFormat('dd.MM.yyyy').format(value);
            _showFilterDialog(
              context,
              FilterParameter.date,
              desksStore.filterStore.toggleValueFilter,
              desksStore.filterStore.resetFilter,
              valueAsString,
            );
          },
        ),
      ),
      Observer(
        builder: (context) => RoundedButton(
          title: filterParameterNames[FilterParameter.time] ?? '',
          isSelected:
              desksStore.filterStore.filters[FilterParameter.time] != null,
          onTap: () {
            final now = DateTime.now();
            TimeOfDay? value =
                desksStore.filterStore.filters[FilterParameter.time];
            String? valueAsString = value == null
                ? null
                : DateFormat.jm().format(DateTime(
                    now.year, now.month, now.day, value.hour, value.minute));
            _showFilterDialog(
              context,
              FilterParameter.time,
              desksStore.filterStore.toggleValueFilter,
              desksStore.filterStore.resetFilter,
              valueAsString,
            );
          },
        ),
      ),
      Observer(
        builder: (context) => RoundedButton(
          title: filterParameterNames[FilterParameter.secondMonitor] ?? '',
          isSelected:
              desksStore.filterStore.filters[FilterParameter.secondMonitor] !=
                  null,
          onTap: () => desksStore.filterStore
              .toggleSimpleFilter(FilterParameter.secondMonitor),
        ),
      ),
    ];
  }

  Widget _getContent(context, DesksStore desksStore) {
    return Observer(
      builder: (_) {
        if (desksStore.inProgress) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return WorkspaceGrid(
            workspaces: desksStore.desks,
            onTap: (desk) => showDialog(
              context: context,
              builder: (context) => MakeReservationDialog(
                workspace: desk,
                onConfirm: desksStore.reserveDesk,
              ),
            ),
          );
        }
      },
    );
  }

  void _showFilterDialog(
    context,
    FilterParameter filter,
    Function(FilterParameter parameter, String valueAsString) onConfirm,
    Function(FilterParameter parameter) onReset,
    String? initialText,
  ) {
    showDialog(
      context: context,
      builder: (context) => FilterDialog(
        filter: filter,
        onConfirm: onConfirm,
        onReset: onReset,
        initialText: initialText,
      ),
    );
  }
}
