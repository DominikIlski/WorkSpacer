import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/stores/block_store.dart';
import 'package:work_spacer/stores/filter_store.dart';

part 'desks_store.g.dart';

class DesksStore = _DesksStore with _$DesksStore;

abstract class _DesksStore with Store {
  final FilterStore filterStore = FilterStore([
    FilterParameter.floor,
    FilterParameter.date,
    FilterParameter.time,
    FilterParameter.secondMonitor,
  ]);

  @observable
  bool inProgress = false;

  @observable
  List<Desk>? _desks;

  //TODO discuss if we want to actually filter list manually or do we want to have endpoint to fetch them with filters as arguments
  @computed
  ObservableList<Desk> get desks => ObservableList.of(
        (_desks ?? []).where((desk) {
          final isFloorValid =
              _checkFilterEqual(FilterParameter.floor, desk.floor);

          const isDateValid = true; //TODO check availability for date
          const isTimeValid = true; //TODO check availability for time

          final isSecondMonitorValid = _checkFilterEqual(
              FilterParameter.secondMonitor, desk.secondMonitor);

          return isFloorValid &&
              isDateValid &&
              isTimeValid &&
              isSecondMonitorValid;
        }).toList(),
      );

  bool _checkFilterEqual(FilterParameter filter, dynamic deskAttribute) {
    final filterValue = filterStore.filters[filter];
    if (filterValue != null && filterValue != deskAttribute) {
      return false;
    } else {
      return true;
    }
  }

  @action
  fetchDesks() async {
    inProgress = true;
    //TODO handle backend
    await Future.delayed(const Duration(milliseconds: 500));
    _desks = desksDummy..sort((desk1, desk2) => desk1.id.compareTo(desk2.id));
    inProgress = false;
  }

  @action
  reserveDesk(
      Workspace deskAsWorkspace, DateTime date, TimeOfDay time, int hours) {
    final Desk desk = deskAsWorkspace as Desk;
    print('$desk, $date, $time, $hours');
    print(TimeOfDay.now());
    //TODO handle backend
  }

  // Future<List<int>> _getAvailableDeskIdsByDate(DateTime date) async {
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   return [1,81];
  // }
}
