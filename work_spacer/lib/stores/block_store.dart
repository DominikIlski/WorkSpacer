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
          final isIdValid = _checkFilterEqual(FilterParameter.id, desk.id);
          final isFloorValid =
              _checkFilterEqual(FilterParameter.floor, desk.floor);
          return isIdValid && isFloorValid;
        }).toList(),
      );

  @computed
  ObservableList<Room> get rooms => ObservableList.of(
        (_rooms ?? []).where((room) {
          final isIdValid = _checkFilterEqual(FilterParameter.id, room.id);
          final isFloorValid =
              _checkFilterEqual(FilterParameter.floor, room.floor);
          return isIdValid && isFloorValid;
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
    inProgressDesks = true;
    //TODO handle backend
    await Future.delayed(const Duration(milliseconds: 500));
    _desks = desksDummy..sort((desk1, desk2) => desk1.id.compareTo(desk2.id));
    inProgressDesks = false;
  }

  @action
  fetchRooms() async {
    inProgressRooms = true;
    //TODO handle backend
    await Future.delayed(const Duration(seconds: 1));
    _rooms = roomsDummy..sort((room1, room2) => room1.id.compareTo(room2.id));
    inProgressRooms = false;
  }

  @action
  void block(Workspace workspace, DateTime startDate, DateTime endDate) {
    //WE ARE NOT VALIDATING DATES SO WE NEED TO HANDLE BLOCK OVERLAPS ON BACKEND
    //IF WORKSPACE IS ALREADY BLOCKED FOR THIS RANGE OR MORE -> IGNORE
    //IF BLOCK ONLY OVERLAPS PARTLY, TAKE ONLY THE NON-OVERLAPPING PART
    //EG. IF THERE ALREADY IS BLOCK 15.06.-18.06. AND NEW BLOCK IS 17.06.-21.06, ADD NEW BLOCK 19.06.-21.06.
    if (workspace is Desk) {
      //TODO handle backend with workspace as Desk
    } else {
      //TODO handle backend with workspace as Room
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
    secondMonitor: true,
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
    secondMonitor: true,
  ),
  const Desk(
    id: 57,
    floor: 1,
    secondMonitor: true,
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
    secondMonitor: true,
  )
];

final List<Room> roomsDummy = [
  const Room(
    id: 1,
    floor: 1,
    capacity: 12,
    hasProjector: true,
    hasWhiteboard: true,
    hasTeleconference: true,
  ),
  const Room(
    id: 5,
    floor: 2,
    capacity: 16,
    hasProjector: false,
    hasWhiteboard: false,
    hasTeleconference: true,
  ),
  const Room(
    id: 3,
    floor: 2,
    capacity: 22,
    hasProjector: false,
    hasWhiteboard: true,
    hasTeleconference: false,
  ),
  const Room(
    id: 61,
    floor: 1,
    capacity: 30,
    hasProjector: true,
    hasWhiteboard: true,
    hasTeleconference: false,
  ),
  const Room(
    id: 12,
    floor: 3,
    capacity: 16,
    hasProjector: true,
    hasWhiteboard: false,
    hasTeleconference: true,
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
