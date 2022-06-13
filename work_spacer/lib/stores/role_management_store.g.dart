// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_management_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RoleManagementStore on _RoleManagementStore, Store {
  Computed<ObservableList<User>>? _$usersComputed;

  @override
  ObservableList<User> get users =>
      (_$usersComputed ??= Computed<ObservableList<User>>(() => super.users,
              name: '_RoleManagementStore.users'))
          .value;

  late final _$inProgressAtom =
      Atom(name: '_RoleManagementStore.inProgress', context: context);

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

  late final _$_usersAtom =
      Atom(name: '_RoleManagementStore._users', context: context);

  @override
  ObservableList<User>? get _users {
    _$_usersAtom.reportRead();
    return super._users;
  }

  @override
  set _users(ObservableList<User>? value) {
    _$_usersAtom.reportWrite(value, super._users, () {
      super._users = value;
    });
  }

  late final _$fetchUsersAsyncAction =
      AsyncAction('_RoleManagementStore.fetchUsers', context: context);

  @override
  Future fetchUsers() {
    return _$fetchUsersAsyncAction.run(() => super.fetchUsers());
  }

  late final _$_RoleManagementStoreActionController =
      ActionController(name: '_RoleManagementStore', context: context);

  @override
  dynamic setUserRole(User user, Role role) {
    final _$actionInfo = _$_RoleManagementStoreActionController.startAction(
        name: '_RoleManagementStore.setUserRole');
    try {
      return super.setUserRole(user, role);
    } finally {
      _$_RoleManagementStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
inProgress: ${inProgress},
users: ${users}
    ''';
  }
}
