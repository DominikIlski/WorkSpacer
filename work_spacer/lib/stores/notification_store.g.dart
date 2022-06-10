// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationStore on _NotificationStore, Store {
  Computed<ObservableList<Notification>>? _$notificationsComputed;

  @override
  ObservableList<Notification> get notifications => (_$notificationsComputed ??=
          Computed<ObservableList<Notification>>(() => super.notifications,
              name: '_NotificationStore.notifications'))
      .value;

  late final _$inProgressAtom =
      Atom(name: '_NotificationStore.inProgress', context: context);

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

  late final _$_notificationsAtom =
      Atom(name: '_NotificationStore._notifications', context: context);

  @override
  ObservableList<Notification>? get _notifications {
    _$_notificationsAtom.reportRead();
    return super._notifications;
  }

  @override
  set _notifications(ObservableList<Notification>? value) {
    _$_notificationsAtom.reportWrite(value, super._notifications, () {
      super._notifications = value;
    });
  }

  late final _$fetchNotificationsAsyncAction =
      AsyncAction('_NotificationStore.fetchNotifications', context: context);

  @override
  Future fetchNotifications() {
    return _$fetchNotificationsAsyncAction
        .run(() => super.fetchNotifications());
  }

  late final _$_NotificationStoreActionController =
      ActionController(name: '_NotificationStore', context: context);

  @override
  dynamic readNotifications() {
    final _$actionInfo = _$_NotificationStoreActionController.startAction(
        name: '_NotificationStore.readNotifications');
    try {
      return super.readNotifications();
    } finally {
      _$_NotificationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
inProgress: ${inProgress},
notifications: ${notifications}
    ''';
  }
}
