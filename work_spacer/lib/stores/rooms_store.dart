import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/models/room.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/stores/block_store.dart';
import 'package:work_spacer/stores/filter_store.dart';

import '../src/helpers/proxy.dart';

part 'rooms_store.g.dart';

class RoomsStore = _RoomsStore with _$RoomsStore;

abstract class _RoomsStore with Store {
  final FilterStore filterStore = FilterStore([
    FilterParameter.floor,
    FilterParameter.date,
    FilterParameter.time,
    FilterParameter.duration,
    FilterParameter.capacity,
    FilterParameter.whiteboard,
    FilterParameter.projector,
    FilterParameter.teleconference,
  ]);

  @observable
  bool inProgress = false;

  @observable
  List<Room>? _rooms;

  @computed
  ObservableList<Room> get rooms => ObservableList.of(
        (_rooms ?? []).where((room) {
          final isFloorValid =
              _checkFilterEqual(FilterParameter.floor, room.floor);
          final isCapacityValid =
              _checkFilterLessOrEqual(FilterParameter.capacity, room.capacity);
          final isWhiteboardValid =
              _checkFilterEqual(FilterParameter.whiteboard, room.whiteboard);
          final isProjectorValid =
              _checkFilterEqual(FilterParameter.projector, room.projector);
          final isTeleconferenceValid = _checkFilterEqual(
              FilterParameter.teleconference, room.teleconferenceSystem);

          final isAvailable = _checkAvailability();

          return isFloorValid &&
              isCapacityValid &&
              isWhiteboardValid &&
              isProjectorValid &&
              isTeleconferenceValid &&
              isAvailable;
        }).toList(),
      );

  bool _checkFilterEqual(FilterParameter filter, dynamic roomAttribute) {
    final filterValue = filterStore.filters[filter];
    if (filterValue != null && filterValue != roomAttribute) {
      return false;
    } else {
      return true;
    }
  }

  bool _checkFilterLessOrEqual(FilterParameter filter, dynamic roomAttribute) {
    final filterValue = filterStore.filters[filter];
    if (filterValue != null && filterValue > roomAttribute) {
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
  fetchRooms() async {
    inProgress = true;
    //TODO handle backend
    //IMPORTANT! we need to limit this list based on the role (see User.dart -> enum), so strapi model should implement something like a list of roles that can acces each workspace,
    // e.g. Room #3 should have a list [Mid, Senior] and when fetching data here, only fetch workspaces that the user can actually access
    // await Future.delayed(const Duration(milliseconds: 500));

    var res = await Proxy.data('conference-rooms');
    var jsonRooms = res['data'].map((e) {
      return <String, dynamic>{"id": e['id'], ...e['attributes']};
    }).toList();

    var rooms =
        jsonRooms.map<Room>((e) => Room.fromJson(e)).toList() as List<Room>;

    _rooms = rooms..sort((room1, room2) => room1.id.compareTo(room2.id));
    inProgress = false;
  }

  @action
  reserveRoom(int? userId, Workspace roomAsWorkspace, DateTime date,
      TimeOfDay time, int hours) async {
    if (userId == null) {
      return;
    }
    final Room room = roomAsWorkspace as Room;
    var combinedDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    var res = await Proxy.data('cr-reservation', method: "POST", body: {
      "startDate": combinedDate.toIso8601String(),
      "duration": hours,
      "idDesk": room.id,
      "idEmployee": userId
    });
  }
}
