// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'desks_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DesksStore on _DesksStore, Store {
  Computed<ObservableList<Desk>>? _$desksComputed;

  @override
  ObservableList<Desk> get desks =>
      (_$desksComputed ??= Computed<ObservableList<Desk>>(() => super.desks,
              name: '_DesksStore.desks'))
          .value;

  late final _$inProgressAtom =
      Atom(name: '_DesksStore.inProgress', context: context);

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

  late final _$_desksAtom = Atom(name: '_DesksStore._desks', context: context);

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

  late final _$fetchDesksAsyncAction =
      AsyncAction('_DesksStore.fetchDesks', context: context);

  @override
  Future fetchDesks() {
    return _$fetchDesksAsyncAction.run(() => super.fetchDesks());
  }

  late final _$_DesksStoreActionController =
      ActionController(name: '_DesksStore', context: context);

  @override
  dynamic reserveDesk(
      Workspace deskAsWorkspace, DateTime date, TimeOfDay time, int hours) {
    final _$actionInfo = _$_DesksStoreActionController.startAction(
        name: '_DesksStore.reserveDesk');
    try {
      return super.reserveDesk(deskAsWorkspace, date, time, hours);
    } finally {
      _$_DesksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
inProgress: ${inProgress},
desks: ${desks}
    ''';
  }
}
