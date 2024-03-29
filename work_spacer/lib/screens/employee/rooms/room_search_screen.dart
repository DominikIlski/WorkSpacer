import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/i18n.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/screens/widgets/workspace_grid.dart';
import 'package:work_spacer/screens/widgets/rounded_button.dart';
import 'package:work_spacer/screens/widgets/filterable_workspace_list.dart';
import 'package:work_spacer/screens/widgets/make_reservation_dialog.dart';
import 'package:work_spacer/screens/widgets/filter_dialog.dart';
import 'package:work_spacer/stores/rooms_store.dart';

class RoomSearchScreen extends StatelessWidget {
  static const routeName = '/rooms';

  const RoomSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roomsStore = Provider.of<RoomsStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(translate.rooms),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilterableWorkspaceList(
          observerFilterButtons: _getObserverFilterButtons(roomsStore),
          child: _getContent(context, roomsStore),
        ),
      ),
    );
  }

  List<Observer> _getObserverFilterButtons(RoomsStore roomsStore) {
    return [
      Observer(
        builder: (context) => RoundedButton(
          title: filterParameterNames[FilterParameter.floor] ?? '',
          isSelected:
              roomsStore.filterStore.filters[FilterParameter.floor] != null,
          onTap: () => _showFilterDialog(
            context,
            FilterParameter.floor,
            roomsStore.filterStore.toggleValueFilter,
            roomsStore.filterStore.resetFilter,
            roomsStore.filterStore.filters[FilterParameter.floor]?.toString(),
          ),
        ),
      ),
      Observer(
        builder: (context) => RoundedButton(
          title: filterParameterNames[FilterParameter.date] ?? '',
          isSelected:
              roomsStore.filterStore.filters[FilterParameter.date] != null,
          onTap: () {
            DateTime? value =
                roomsStore.filterStore.filters[FilterParameter.date];
            String? valueAsString =
                value == null ? null : DateFormat('dd.MM.yyyy').format(value);
            _showFilterDialog(
              context,
              FilterParameter.date,
              roomsStore.filterStore.toggleValueFilter,
              roomsStore.filterStore.resetFilter,
              valueAsString,
            );
          },
        ),
      ),
      Observer(
        builder: (context) => RoundedButton(
          title: filterParameterNames[FilterParameter.time] ?? '',
          isSelected:
              roomsStore.filterStore.filters[FilterParameter.time] != null,
          onTap: () {
            final now = DateTime.now();
            TimeOfDay? value =
                roomsStore.filterStore.filters[FilterParameter.time];
            String? valueAsString = value == null
                ? null
                : DateFormat.jm().format(DateTime(
                    now.year, now.month, now.day, value.hour, value.minute));
            _showFilterDialog(
              context,
              FilterParameter.time,
              roomsStore.filterStore.toggleValueFilter,
              roomsStore.filterStore.resetFilter,
              valueAsString,
            );
          },
        ),
      ),
      Observer(
        builder: (context) => RoundedButton(
          title: filterParameterNames[FilterParameter.capacity] ?? '',
          isSelected:
              roomsStore.filterStore.filters[FilterParameter.capacity] != null,
          onTap: () => _showFilterDialog(
            context,
            FilterParameter.capacity,
            roomsStore.filterStore.toggleValueFilter,
            roomsStore.filterStore.resetFilter,
            roomsStore.filterStore.filters[FilterParameter.capacity]
                ?.toString(),
          ),
        ),
      ),
      Observer(
        builder: (context) => RoundedButton(
          title: filterParameterNames[FilterParameter.whiteboard] ?? '',
          isSelected:
              roomsStore.filterStore.filters[FilterParameter.whiteboard] !=
                  null,
          onTap: () => roomsStore.filterStore
              .toggleSimpleFilter(FilterParameter.whiteboard),
        ),
      ),
      Observer(
        builder: (context) => RoundedButton(
          title: filterParameterNames[FilterParameter.projector] ?? '',
          isSelected:
              roomsStore.filterStore.filters[FilterParameter.projector] != null,
          onTap: () => roomsStore.filterStore
              .toggleSimpleFilter(FilterParameter.projector),
        ),
      ),
      Observer(
        builder: (context) => RoundedButton(
          title: filterParameterNames[FilterParameter.teleconference] ?? '',
          isSelected:
              roomsStore.filterStore.filters[FilterParameter.teleconference] !=
                  null,
          onTap: () => roomsStore.filterStore
              .toggleSimpleFilter(FilterParameter.teleconference),
        ),
      ),
    ];
  }

  Widget _getContent(context, RoomsStore roomsStore) {
    return Observer(
      builder: (_) {
        if (roomsStore.inProgress) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return WorkspaceGrid(
            workspaces: roomsStore.rooms,
            onTap: (room) => showDialog(
              context: context,
              builder: (context) => MakeReservationDialog(
                workspace: room,
                onConfirm: roomsStore.reserveRoom,
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
