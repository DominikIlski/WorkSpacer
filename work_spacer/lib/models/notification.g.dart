// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      _deskFromJson(json['desks']),
      _roomFromJson(json['conference_rooms']),
      _deskReservationFromJson(json['desk_reservation']),
      _roomReservationFromJson(json['cr_reservation']),
      json['isNew'] as bool,
      json['id'] as int,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'desk_reservation': instance.deskReservation?.toJson(),
      'cr_reservation': instance.roomReservation?.toJson(),
      'desks': instance.desks?.map((e) => e.toJson()).toList(),
      'conference_rooms':
          instance.conferenceRooms?.map((e) => e.toJson()).toList(),
      'isNew': instance.isNew,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Notification on _Notification, Store {
  late final _$isNewAtom = Atom(name: '_Notification.isNew', context: context);

  @override
  bool get isNew {
    _$isNewAtom.reportRead();
    return super.isNew;
  }

  @override
  set isNew(bool value) {
    _$isNewAtom.reportWrite(value, super.isNew, () {
      super.isNew = value;
    });
  }

  late final _$_NotificationActionController =
      ActionController(name: '_Notification', context: context);

  @override
  dynamic readNotification() {
    final _$actionInfo = _$_NotificationActionController.startAction(
        name: '_Notification.readNotification');
    try {
      return super.readNotification();
    } finally {
      _$_NotificationActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isNew: ${isNew}
    ''';
  }
}
