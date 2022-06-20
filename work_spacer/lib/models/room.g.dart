// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      id: json['id'] as int,
      floor: json['floor'] as int,
      capacity: json['capacity'] as int,
      projector: json['projector'] as bool,
      whiteboard: json['whiteboard'] as bool,
      teleconferenceSystem: json['teleconferenceSystem'] as bool,
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'id': instance.id,
      'floor': instance.floor,
      'capacity': instance.capacity,
      'projector': instance.projector,
      'whiteboard': instance.whiteboard,
      'teleconferenceSystem': instance.teleconferenceSystem,
    };
