import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/src/helpers/proxy.dart';
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
    //IMPORTANT! we need to limit this list based on the role (see User.dart -> enum), so strapi model should implement something like a list of roles that can acces each workspace,
    // e.g. Desk #3 should have a list [Mid, Senior] and when fetching data here, only fetch workspaces that the user can actually access
    // await Future.delayed(const Duration(milliseconds: 500));
    var res = await Proxy.data('desks');
    var jsonDesks = res['data'].map((e) {
      return <String, dynamic>{
        "id": e['id'],
        ...e['attributes']
      };
    }).toList();

    var desks = jsonDesks.map<Desk>((e)=> Desk.fromJson(e)).toList() as List<Desk>;
    _desks = desks..sort((desk1, desk2) => desk1.id.compareTo(desk2.id));
    inProgress = false;
  }

  @action
  reserveDesk(int? userId, Workspace deskAsWorkspace, DateTime date,
      TimeOfDay time, int hours) async {
    if (userId == null) {
      return;
    }
    final Desk desk = deskAsWorkspace as Desk;
    var combinedDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    var res = await Proxy.data('desk-reservations', method: "POST", body: {
      "startDate": combinedDate.toIso8601String(),
      "duration": hours,
      "idDesk": desk.id,
      "idEmployee": userId
    });
    
    //TODO handle backend
    //WE ARE NOT VALIDATING DATE TIME NOR HOURS SO IT NEEDS TO BE DONE AT BACKEND
    //IF POSSIBLE MAKE A RESERVATION, IF NOT IGNORE XD
  }
}
