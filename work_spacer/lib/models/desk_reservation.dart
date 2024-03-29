import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/reservation.dart';

part 'desk_reservation.g.dart';

@immutable
@JsonSerializable()
class DeskReservation extends Reservation {
  @JsonKey(fromJson: _deskFromJson, name: 'idDesk')
  final Desk desk;
@JsonKey(name: "idDeskCancellation", fromJson: _cancelationFromJson)
  final bool isCancelled;
  const DeskReservation({
    this.isCancelled = false,
    required this.desk,
    required super.id,
    required super.startDate,
    required super.duration,
    required super.idEmployee,
  });

  @override
  bool get canceled => isCancelled;

  factory DeskReservation.fromJson(Map<String, dynamic> json) => _$DeskReservationFromJson(json);
  Map<String, dynamic> toJson() => _$DeskReservationToJson(this);
}

Desk _deskFromJson(dynamic data) {
  var json = Map<String, dynamic>.from(data);
  var ob = <String, dynamic>{
    "id": json['data']['id'],
    ...json['data']['attributes']
  };
  return Desk.fromJson(ob);
}

int _employeeFromJson(dynamic data) {
  var json = Map<String, dynamic>.from(data);
  return json['data']['id'];
}

bool _cancelationFromJson(dynamic data) {
  var json = Map<String, dynamic>.from(data);
  return json['data'] != null ;
}
// jsonDecode(json)['idDesk']['data']['id']