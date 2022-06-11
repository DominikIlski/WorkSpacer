// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BlockStore on _BlockStore, Store {
  Computed<ObservableList<Desk>>? _$desksComputed;

  @override
  ObservableList<Desk> get desks =>
      (_$desksComputed ??= Computed<ObservableList<Desk>>(() => super.desks,
              name: '_BlockStore.desks'))
          .value;
  Computed<ObservableList<Room>>? _$roomsComputed;

  @override
  ObservableList<Room> get rooms =>
      (_$roomsComputed ??= Computed<ObservableList<Room>>(() => super.rooms,
              name: '_BlockStore.rooms'))
          .value;

  late final _$inProgressDesksAtom =
      Atom(name: '_BlockStore.inProgressDesks', context: context);

  @override
  bool get inProgressDesks {
    _$inProgressDesksAtom.reportRead();
    return super.inProgressDesks;
  }

  @override
  set inProgressDesks(bool value) {
    _$inProgressDesksAtom.reportWrite(value, super.inProgressDesks, () {
      super.inProgressDesks = value;
    });
  }

  late final _$inProgressRoomsAtom =
      Atom(name: '_BlockStore.inProgressRooms', context: context);

  @override
  bool get inProgressRooms {
    _$inProgressRoomsAtom.reportRead();
    return super.inProgressRooms;
  }

  @override
  set inProgressRooms(bool value) {
    _$inProgressRoomsAtom.reportWrite(value, super.inProgressRooms, () {
      super.inProgressRooms = value;
    });
  }

  late final _$_desksAtom = Atom(name: '_BlockStore._desks', context: context);

  @override
  List<Desk>? get _desks {
    _$_desksAtom.reportRead();
    return super._desks;
  }

  @override
  set _desks(List<Desk>? value) {
    _$_desksAtom.reportWrite(value, super._desks, () {
      super._desks = value;
    });
  }

  late final _$_roomsAtom = Atom(name: '_BlockStore._rooms', context: context);

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

  late final _$fetchDesksAsyncAction =
      AsyncAction('_BlockStore.fetchDesks', context: context);

  @override
  Future fetchDesks() {
    return _$fetchDesksAsyncAction.run(() => super.fetchDesks());
  }

  late final _$fetchRoomsAsyncAction =
      AsyncAction('_BlockStore.fetchRooms', context: context);

  @override
  Future fetchRooms() {
    return _$fetchRoomsAsyncAction.run(() => super.fetchRooms());
  }

  late final _$_BlockStoreActionController =
      ActionController(name: '_BlockStore', context: context);

  @override
  void block(Workspace workspace, DateTime startDate, DateTime endDate) {
    final _$actionInfo =
        _$_BlockStoreActionController.startAction(name: '_BlockStore.block');
    try {
      return super.block(workspace, startDate, endDate);
    } finally {
      _$_BlockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
inProgressDesks: ${inProgressDesks},
inProgressRooms: ${inProgressRooms},
desks: ${desks},
rooms: ${rooms}
    ''';
  }
}
