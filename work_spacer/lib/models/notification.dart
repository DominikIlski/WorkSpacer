import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/desk_reservation.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/models/room.dart';
import 'package:work_spacer/models/room_reservation.dart';
import 'package:work_spacer/models/workspace.dart';

part 'notification.g.dart';

// ignore: invalid_annotation_target
@JsonSerializable(explicitToJson: true)
class Notification extends _Notification with _$Notification {
  Notification(super.desks, super.conferenceRooms, super.deskReservation,
      super.roomReservation, super.isNew, super.id);
  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}

abstract class _Notification with Store {
  _Notification(
    this.desks,
    this.conferenceRooms,
    this.deskReservation,
    this.roomReservation,
    this.isNew, this.id,
  );
  final int id;
  @JsonKey(ignore: true)
  Reservation get reservation => deskReservation ?? roomReservation!;

  @JsonKey(name: 'desk_reservation', fromJson: _deskReservationFromJson)
  final DeskReservation? deskReservation;
  @JsonKey(name: 'cr_reservation', fromJson: _roomReservationFromJson)
  final RoomReservation? roomReservation;

  @JsonKey(
    fromJson: _deskFromJson,
  )
  final List<Desk>? desks;
  @JsonKey(
    name: 'conference_rooms',
    fromJson: _roomFromJson,
  )
  final List<Room>? conferenceRooms;
  @JsonKey(ignore: true)
  List<Workspace> get replacements =>
      [...(desks ?? []), ...(conferenceRooms ?? [])];

  @observable
  bool isNew;

  @action
  readNotification() {
    isNew = false;
  }

  int compareTo(Notification other) {
    if (isNew && other.isNew) {
      return reservation.startDate.compareTo(other.reservation.startDate);
    } else if (isNew) {
      return -1;
    } else {
      return 1;
    }
  }
}

List<Room> _roomFromJson(dynamic data) {
  var jsonList = Map<String, dynamic>.from(data);
  return (jsonList['data'] as List<dynamic>)
      .map((json) => Room.fromJson({"id": json['id'], ...json['attributes']}))
      .toList();
}

List<Desk> _deskFromJson(dynamic data) {
  var jsonList = Map<String, dynamic>.from(data);
  return (jsonList['data'] as List<dynamic>)
      .map((json) => Desk.fromJson({"id": json['id'], ...json['attributes']}))
      .toList();
}

RoomReservation? _roomReservationFromJson(dynamic data) {
  var json = Map<String, dynamic>.from(data);
  if (json['data'] == null) {
    return null;
  }
  var ob = <String, dynamic>{
    "id": json['data']['id'],
    ...json['data']['attributes']
  };
  return RoomReservation.fromJson(ob);
}

DeskReservation? _deskReservationFromJson(dynamic data) {
  var json = Map<String, dynamic>.from(data);
  if (json['data'] == null) {
    return null;
  }
  var ob = <String, dynamic>{
    "id": json['data']['id'],
    ...json['data']['attributes']
  };
  return DeskReservation.fromJson(ob);
}
