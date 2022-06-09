// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CancelStore on _CancelStore, Store {
  Computed<ObservableList<Reservation>>? _$filteredReservationsComputed;

  @override
  ObservableList<Reservation> get filteredReservations =>
      (_$filteredReservationsComputed ??= Computed<ObservableList<Reservation>>(
              () => super.filteredReservations,
              name: '_CancelStore.filteredReservations'))
          .value;

  late final _$inProgressAtom =
      Atom(name: '_CancelStore.inProgress', context: context);

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

  late final _$searchWorkspaceIdAtom =
      Atom(name: '_CancelStore.searchWorkspaceId', context: context);

  @override
  String get searchWorkspaceId {
    _$searchWorkspaceIdAtom.reportRead();
    return super.searchWorkspaceId;
  }

  @override
  set searchWorkspaceId(String value) {
    _$searchWorkspaceIdAtom.reportWrite(value, super.searchWorkspaceId, () {
      super.searchWorkspaceId = value;
    });
  }

  late final _$_reservationsAtom =
      Atom(name: '_CancelStore._reservations', context: context);

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
      AsyncAction('_CancelStore.fetchReservations', context: context);

  @override
  Future fetchReservations() {
    return _$fetchReservationsAsyncAction.run(() => super.fetchReservations());
  }

  late final _$_CancelStoreActionController =
      ActionController(name: '_CancelStore', context: context);

  @override
  dynamic setSearchWorkspaceId(String value) {
    final _$actionInfo = _$_CancelStoreActionController.startAction(
        name: '_CancelStore.setSearchWorkspaceId');
    try {
      return super.setSearchWorkspaceId(value);
    } finally {
      _$_CancelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cancel(Reservation reservation) {
    final _$actionInfo =
        _$_CancelStoreActionController.startAction(name: '_CancelStore.cancel');
    try {
      return super.cancel(reservation);
    } finally {
      _$_CancelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
inProgress: ${inProgress},
searchWorkspaceId: ${searchWorkspaceId},
filteredReservations: ${filteredReservations}
    ''';
  }
}
