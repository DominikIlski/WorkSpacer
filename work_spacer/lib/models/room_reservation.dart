import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/models/room.dart';

part 'room_reservation.g.dart';

@immutable
@JsonSerializable()
class RoomReservation extends Reservation {
  @JsonKey(fromJson: _roomFromJson, name: 'idConferenceRoom')
  final Room room;
  @JsonKey(name: "idCRCancellation", fromJson: _cancelationFromJson)
  final bool isCancelled;
  const RoomReservation({
    this.isCancelled = false,
    required this.room,
    required super.id,
    required super.startDate,
    required super.duration,
    required super.idEmployee,
  });

  @override
  bool get canceled => isCancelled;

  factory RoomReservation.fromJson(Map<String, dynamic> json) =>
      _$RoomReservationFromJson(json);
  Map<String, dynamic> toJson() => _$RoomReservationToJson(this);
}

Room _roomFromJson(dynamic data) {
  var json = Map<String, dynamic>.from(data);
  var ob = <String, dynamic>{
    "id": json['data']['id'],
    ...json['data']['attributes']
  };
  return Room.fromJson(ob);
}

int _employeeFromJson(dynamic data) {
  var json = Map<String, dynamic>.from(data);
  return json['data']['id'];
}

bool _cancelationFromJson(dynamic data) {
  var json = Map<String, dynamic>.from(data);
  return json['data'] != null ;
}