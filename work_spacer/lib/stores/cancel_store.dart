import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/desk_reservation.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/models/room.dart';
import 'package:work_spacer/models/room_reservation.dart';

import '../src/helpers/proxy.dart';

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
    var res = await Proxy.data('desk-reservations');
    var jsonDeskR = res['data'].map((e) {
      return <String, dynamic>{"id": e['id'], ...e['attributes']};
    }).toList();

    var dReservations = jsonDeskR
        .map<DeskReservation>((e) => DeskReservation.fromJson(e))
        .toList() as List<DeskReservation>;

    var res1 = await Proxy.data('cr-reservations');
    var jsonRoomsR = res1['data'].map((e) {
      return <String, dynamic>{"id": e['id'], ...e['attributes']};
    }).toList();

    var rReservations = jsonRoomsR
        .map<RoomReservation>((e) => RoomReservation.fromJson(e))
        .toList() as List<RoomReservation>;
    var reservationsData = <Reservation>[...dReservations, ...rReservations]
      .where((element) => !element.canceled)
      .toList();
    _reservations = ObservableList.of(
      reservationsData
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
  cancel(Reservation reservation, int adminId) async {
    var isDesk = reservation.runtimeType == DeskReservation;
    var res = await Proxy.data(!isDesk ? 'cr-cancellations' : 'desk-cancellations', method: 'POST', body: {
      "idAdmin": adminId,
      if(!isDesk)
      "idCRReservation": reservation.id,
      if(isDesk)
      "idDeskReservation": reservation.id
    });
    var res1 = await Proxy.notifyUser(isDesk,  reservation.id);
    
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
      projector: true,
      whiteboard: false,
      teleconferenceSystem: false,
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
      projector: true,
      whiteboard: false,
      teleconferenceSystem: false,
    ),
    id: 8,
    startDate: DateTime.now().subtract(const Duration(days: 2)),
    duration: 4,
    idEmployee: 11,
  ),
];
