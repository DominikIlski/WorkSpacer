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
    FilterParameter.duration,
    FilterParameter.secondMonitor,
  ]);

  @observable
  bool inProgress = false;

  @observable
  List<Desk>? _desks;

  @computed
  ObservableList<Desk> get desks => ObservableList.of(
        (_desks ?? []).where((desk) {
          final isFloorValid =
              _checkFilterEqual(FilterParameter.floor, desk.floor);

          final isAvailable = _checkAvailability();

          final isSecondMonitorValid = _checkFilterEqual(
              FilterParameter.secondMonitor, desk.secondMonitor);

          return isFloorValid && isAvailable && isSecondMonitorValid;
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

  bool _checkAvailability() {
    DateTime? date = filterStore.filters[FilterParameter.date];
    TimeOfDay? time = filterStore.filters[FilterParameter.time];
    int? hours = filterStore.filters[FilterParameter.duration];
    //TODO handle backend
    //ALL COMBINATIONS ARE POSSIBLE:
    if (date != null) {
      if (time != null) {
        if (hours != null) {
          //CHECK ALL THREE
          //return
        } else {
          //CHECK DATE AND TIME
          //return
        }
      } else {
        if (hours != null) {
          //CHECK DATE AND HOURS
          //return
        } else {
          //CHECK DATE
        }
      }
    } else {
      if (time != null) {
        if (hours != null) {
          //CHECK TIME AND HOURS
          //return
        } else {
          //CHECK TIME
          //return
        }
      } else {
        if (hours != null) {
          //CHECK HOURS
          //return
        } else {
          return true;
        }
      }
    }

    return true;
    //REMOVE ^ WHEN IMPLEMENTED ABOVE
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
  reserveDesk(int? userId, Workspace deskAsWorkspace, DateTime date,
      TimeOfDay time, int hours) {
    if (userId == null) {
      return;
    }
    final Desk desk = deskAsWorkspace as Desk;
    //TODO handle backend
    //WE ARE NOT VALIDATING DATE TIME NOR HOURS SO IT NEEDS TO BE DONE AT BACKEND
    //IF POSSIBLE MAKE A RESERVATION, IF NOT IGNORE XD
  }
}
