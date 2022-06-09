import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/stores/cancel_store.dart';

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
  void cancel(Reservation reservation) {
    //TODO handle backend
    _reservations?.remove(reservation);
  }
}
