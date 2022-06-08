import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/models/room.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/stores/filter_store.dart';

part 'block_store.g.dart';

class BlockStore = _BlockStore with _$BlockStore;

abstract class _BlockStore with Store {
  final FilterStore filterStore = FilterStore([
    FilterParameter.id,
    FilterParameter.floor,
  ]);

  @observable
  bool inProgressDesks = false;

  @observable
  bool inProgressRooms = false;

  @observable
  List<Desk>? _desks;

  @observable
  List<Room>? _rooms;

  @computed
  ObservableList<Desk> get desks => ObservableList.of(
        (_desks ?? []).where((desk) {
          bool result = true;
          final filterId = filterStore.filters[FilterParameter.id];
          final filterFloor = filterStore.filters[FilterParameter.floor];
          if (filterId != null && filterId != desk.id) {
            result = false;
          }
          if (filterFloor != null && filterFloor != desk.floor) {
            result = false;
          }
          return result;
        }).toList()
          ..sort((desk1, desk2) => desk1.id.compareTo(desk2.id)),
      );

  @computed
  ObservableList<Room> get rooms => ObservableList.of(
        (_rooms ?? []).where((room) {
          bool result = true;
          final filterId = filterStore.filters[FilterParameter.id];
          final filterFloor = filterStore.filters[FilterParameter.floor];
          if (filterId != null && filterId != room.id) {
            result = false;
          }
          if (filterFloor != null && filterFloor != room.floor) {
            result = false;
          }
          return result;
        }).toList()
          ..sort((room1, room2) => room1.id.compareTo(room2.id)),
      );

  @action
  fetchDesks() async {
    inProgressDesks = true;
    //TODO handle backend
    await Future.delayed(const Duration(milliseconds: 500));
    _desks = desksDummy;
    inProgressDesks = false;
  }

  @action
  fetchRooms() async {
    inProgressRooms = true;
    //TODO handle backend
    await Future.delayed(const Duration(seconds: 1));
    _rooms = roomsDummy;
    inProgressRooms = false;
  }

  @action
  void block(Workspace workspace) {
    if (workspace is Desk) {
      //TODO handle backend as Desk
    } else {
      //TODO handle backend as Room
    }
  }
}

final List<Desk> desksDummy = [
  const Desk(
    id: 1,
    floor: 2,
    secondMonitor: false,
  ),
  const Desk(
    id: 13,
    floor: 1,
    secondMonitor: false,
  ),
  const Desk(
    id: 14,
    floor: 2,
    secondMonitor: false,
  ),
  const Desk(
    id: 18,
    floor: 1,
    secondMonitor: false,
  ),
  const Desk(
    id: 33,
    floor: 1,
    secondMonitor: false,
  ),
  const Desk(
    id: 57,
    floor: 1,
    secondMonitor: false,
  ),
  const Desk(
    id: 69,
    floor: 2,
    secondMonitor: false,
  ),
  const Desk(
    id: 78,
    floor: 3,
    secondMonitor: false,
  ),
  const Desk(
    id: 81,
    floor: 2,
    secondMonitor: false,
  ),
  const Desk(
    id: 100,
    floor: 3,
    secondMonitor: false,
  )
];

final List<Room> roomsDummy = [
  const Room(
    id: 1,
    floor: 1,
    capacity: 12,
    hasProjector: false,
    hasWhiteboard: false,
    hasTeleconference: false,
  ),
  const Room(
    id: 5,
    floor: 2,
    capacity: 16,
    hasProjector: false,
    hasWhiteboard: false,
    hasTeleconference: false,
  ),
  const Room(
    id: 3,
    floor: 2,
    capacity: 22,
    hasProjector: false,
    hasWhiteboard: false,
    hasTeleconference: false,
  ),
  const Room(
    id: 61,
    floor: 1,
    capacity: 30,
    hasProjector: false,
    hasWhiteboard: false,
    hasTeleconference: false,
  ),
  const Room(
    id: 12,
    floor: 3,
    capacity: 16,
    hasProjector: false,
    hasWhiteboard: false,
    hasTeleconference: false,
  ),
  const Room(
    id: 13,
    floor: 1,
    capacity: 25,
    hasProjector: false,
    hasWhiteboard: false,
    hasTeleconference: false,
  ),
];
