import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/desk_reservation.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/models/room_reservation.dart';
import 'package:work_spacer/stores/cancel_store.dart';

import '../src/helpers/proxy.dart';

part 'reservation_store.g.dart';

class ReservationStore = _ReservationStore with _$ReservationStore;

abstract class _ReservationStore with Store {
  @observable
  bool inProgress = false;

  @observable
  ObservableList<Reservation>? _reservations;

  @computed
  ObservableList<Reservation> get reservations =>
      ObservableList.of(_reservations ?? []);

  @action
  fetchReservations(int userId) async {
    inProgress = true;
    //TODO handle backend

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
      .where((element) => element.idEmployee == userId)
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
  cancel(Reservation reservation) async {
    var res = await Proxy.data('desk-reservations/${reservation.id}', method: "DELETE");
    var res1 = await Proxy.data('cr-reservations/${reservation.id}', method: "DELETE");

    _reservations?.remove(reservation);
  }
}
