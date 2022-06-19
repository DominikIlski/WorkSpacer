// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomReservation _$RoomReservationFromJson(Map<String, dynamic> json) =>
    RoomReservation(
      isCancelled: json['idCRCancellation'] == null
          ? false
          : _cancelationFromJson(json['idCRCancellation']),
      room: _roomFromJson(json['idConferenceRoom']),
      id: json['id'] as int,
      startDate: DateTime.parse(json['startDate'] as String),
      duration: json['duration'] as int,
      idEmployee: _employeeFromJson(json['idEmployee']),
    );

Map<String, dynamic> _$RoomReservationToJson(RoomReservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate.toIso8601String(),
      'duration': instance.duration,
      'idEmployee': instance.idEmployee,
      'idConferenceRoom': instance.room,
      'idCRCancellation': instance.isCancelled,
    };
