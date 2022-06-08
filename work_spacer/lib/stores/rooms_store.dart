import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/models/room.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/stores/block_store.dart';
import 'package:work_spacer/stores/filter_store.dart';

part 'rooms_store.g.dart';

class RoomsStore = _RoomsStore with _$RoomsStore;

abstract class _RoomsStore with Store {
  final FilterStore filterStore = FilterStore([
    FilterParameter.floor,
    FilterParameter.capacity,
    FilterParameter.whiteboard,
    FilterParameter.projector,
    FilterParameter.teleconference,
  ]);

  @observable
  bool inProgress = false;

  @observable
  List<Room>? _rooms;

  //TODO discuss if we want to actually filter list manually or do we want to have endpoint to fetch them with filters as arguments
  @computed
  ObservableList<Room> get rooms => ObservableList.of(
        (_rooms ?? []).where((room) {
          final isFloorValid =
              _checkFilterEqual(FilterParameter.floor, room.floor);
          final isCapacityValid =
              _checkFilterLessOrEqual(FilterParameter.capacity, room.capacity);
          final isWhiteboardValid =
              _checkFilterEqual(FilterParameter.whiteboard, room.hasWhiteboard);
          final isProjectorValid =
              _checkFilterEqual(FilterParameter.projector, room.hasProjector);
          final isTeleconferenceValid = _checkFilterEqual(
              FilterParameter.teleconference, room.hasTeleconference);

          const isDateValid = true; //TODO check availability for date
          const isTimeValid = true; //TODO check availability for time

          return isFloorValid &&
              isCapacityValid &&
              isWhiteboardValid &&
              isProjectorValid &&
              isTeleconferenceValid &&
              isDateValid &&
              isTimeValid;
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

  @action
  fetchRooms() async {
    inProgress = true;
    //TODO handle backend
    await Future.delayed(const Duration(milliseconds: 500));
    _rooms = roomsDummy..sort((room1, room2) => room1.id.compareTo(room2.id));
    inProgress = false;
  }

  @action
  reserveRoom(
      Workspace roomAsWorkspace, DateTime date, TimeOfDay time, int hours) {
    final Room room = roomAsWorkspace as Room;
    print('$room, $date, $time, $hours');
    //TODO handle backend
  }
}
