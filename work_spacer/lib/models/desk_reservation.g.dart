// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'desk_reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeskReservation _$DeskReservationFromJson(Map<String, dynamic> json) =>
    DeskReservation(
      desk: _deskFromJson(json['idDesk']),
      id: json['id'] as int,
      startDate: DateTime.parse(json['startDate'] as String),
      duration: json['duration'] as int,
      idEmployee: _employeeFromJson(json['idEmployee']),
    );

Map<String, dynamic> _$DeskReservationToJson(DeskReservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate.toIso8601String(),
      'duration': instance.duration,
      'idEmployee': instance.idEmployee,
      'idDesk': instance.desk,
    };
