// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$User on _User, Store {
  late final _$roleAtom = Atom(name: '_User.role', context: context);

  @override
  Role get role {
    _$roleAtom.reportRead();
    return super.role;
  }

  @override
  set role(Role value) {
    _$roleAtom.reportWrite(value, super.role, () {
      super.role = value;
    });
  }

  late final _$_UserActionController =
      ActionController(name: '_User', context: context);

  @override
  dynamic setRole(Role newRole) {
    final _$actionInfo =
        _$_UserActionController.startAction(name: '_User.setRole');
    try {
      return super.setRole(newRole);
    } finally {
      _$_UserActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
role: ${role}
    ''';
  }
}
