import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/desk_reservation.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/models/room.dart';
import 'package:work_spacer/models/room_reservation.dart';

part 'cancel_store.g.dart';

class CancelStore = _CancelStore with _$CancelStore;

abstract class _CancelStore with Store {
  @observable
  bool inProgress = false;

  @observable
  String searchWorkspaceId = '';

  @observable
  ObservableList<Reservation>? _reservations;

  @computed
  ObservableList<Reservation> get filteredReservations {
    return ObservableList.of(
      (_reservations ?? <Reservation>[]).where((reservation) {
        String idAsString = reservation is DeskReservation
            ? reservation.desk.id.toString()
            : (reservation as RoomReservation).room.id.toString();
        return idAsString.contains(searchWorkspaceId);
      }).toList(),
    );
  }

  @action
  fetchReservations() async {
    inProgress = true;
    //TODO handle backend
    await Future.delayed(const Duration(milliseconds: 500));
    _reservations = ObservableList.of(
      reservationsDummy
        ..sort(
          (reservation1, reservation2) =>
              reservation1.startDate.compareTo(reservation2.startDate),
        ),
    );
    inProgress = false;
  }

  @action
  setSearchWorkspaceId(String value) {
    searchWorkspaceId = value;
  }

  @action
  void cancel(Reservation reservation) {
    //TODO handle backend and notification
    _reservations?.remove(reservation);
  }
}

final List<Reservation> reservationsDummy = [
  DeskReservation(
    desk: const Desk(
      id: 23,
      floor: 2,
      secondMonitor: false,
    ),
    id: 123,
    startDate: DateTime.now(),
    duration: 3,
    idEmployee: 21,
  ),
  RoomReservation(
    room: const Room(
      id: 15,
      floor: 1,
      capacity: 21,
      hasProjector: true,
      hasWhiteboard: false,
      hasTeleconference: false,
    ),
    id: 111,
    startDate: DateTime.now().subtract(const Duration(days: 12)),
    duration: 2,
    idEmployee: 11,
  ),
  DeskReservation(
    desk: const Desk(
      id: 2,
      floor: 2,
      secondMonitor: false,
    ),
    id: 434,
    startDate: DateTime.now().subtract(const Duration(days: 5)),
    duration: 7,
    idEmployee: 21,
  ),
  RoomReservation(
    room: const Room(
      id: 111,
      floor: 1,
      capacity: 21,
      hasProjector: true,
      hasWhiteboard: false,
      hasTeleconference: false,
    ),
    id: 8,
    startDate: DateTime.now().subtract(const Duration(days: 2)),
    duration: 4,
    idEmployee: 11,
  ),
];
