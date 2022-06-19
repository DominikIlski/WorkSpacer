// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReservationStore on _ReservationStore, Store {
  Computed<ObservableList<Reservation>>? _$reservationsComputed;

  @override
  ObservableList<Reservation> get reservations => (_$reservationsComputed ??=
          Computed<ObservableList<Reservation>>(() => super.reservations,
              name: '_ReservationStore.reservations'))
      .value;

  late final _$inProgressAtom =
      Atom(name: '_ReservationStore.inProgress', context: context);

  @override
  bool get inProgress {
    _$inProgressAtom.reportRead();
    return super.inProgress;
  }

  @override
  set inProgress(bool value) {
    _$inProgressAtom.reportWrite(value, super.inProgress, () {
      super.inProgress = value;
    });
  }

  late final _$_reservationsAtom =
      Atom(name: '_ReservationStore._reservations', context: context);

  @override
  ObservableList<Reservation>? get _reservations {
    _$_reservationsAtom.reportRead();
    return super._reservations;
  }

  @override
  set _reservations(ObservableList<Reservation>? value) {
    _$_reservationsAtom.reportWrite(value, super._reservations, () {
      super._reservations = value;
    });
  }

  late final _$fetchReservationsAsyncAction =
      AsyncAction('_ReservationStore.fetchReservations', context: context);

  @override
  Future fetchReservations(int userId) {
    return _$fetchReservationsAsyncAction
        .run(() => super.fetchReservations(userId));
  }

  late final _$_ReservationStoreActionController =
      ActionController(name: '_ReservationStore', context: context);

  @override
  void cancel(Reservation reservation) {
    final _$actionInfo = _$_ReservationStoreActionController.startAction(
        name: '_ReservationStore.cancel');
    try {
      return super.cancel(reservation);
    } finally {
      _$_ReservationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
inProgress: ${inProgress},
reservations: ${reservations}
    ''';
  }
}
