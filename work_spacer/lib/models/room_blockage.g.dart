// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_blockage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomBlockage _$RoomBlockageFromJson(Map<String, dynamic> json) => RoomBlockage(
      room: Room.fromJson(json['room'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$RoomBlockageToJson(RoomBlockage instance) =>
    <String, dynamic>{
      'room': instance.room,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };
