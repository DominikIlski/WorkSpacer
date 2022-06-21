// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RoomsStore on _RoomsStore, Store {
  Computed<ObservableList<Room>>? _$roomsComputed;

  @override
  ObservableList<Room> get rooms =>
      (_$roomsComputed ??= Computed<ObservableList<Room>>(() => super.rooms,
              name: '_RoomsStore.rooms'))
          .value;

  late final _$inProgressAtom =
      Atom(name: '_RoomsStore.inProgress', context: context);

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

  late final _$_roomsAtom = Atom(name: '_RoomsStore._rooms', context: context);

  @override
  List<Room>? get _rooms {
    _$_roomsAtom.reportRead();
    return super._rooms;
  }

  @override
  set _rooms(List<Room>? value) {
    _$_roomsAtom.reportWrite(value, super._rooms, () {
      super._rooms = value;
    });
  }

  late final _$fetchRoomsAsyncAction =
      AsyncAction('_RoomsStore.fetchRooms', context: context);

  @override
  Future fetchRooms() {
    return _$fetchRoomsAsyncAction.run(() => super.fetchRooms());
  }

  late final _$reserveRoomAsyncAction =
      AsyncAction('_RoomsStore.reserveRoom', context: context);

  @override
  Future<bool> reserveRoom(int? userId, Workspace roomAsWorkspace,
      DateTime date, TimeOfDay time, int hours) {
    return _$reserveRoomAsyncAction.run(
        () => super.reserveRoom(userId, roomAsWorkspace, date, time, hours));
  }

  @override
  String toString() {
    return '''
inProgress: ${inProgress},
rooms: ${rooms}
    ''';
  }
}
