// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'desk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Desk _$DeskFromJson(Map<String, dynamic> json) => Desk(
      id: json['id'] as int,
      floor: json['floor'] as int,
      secondMonitor: json['secondMonitor'] as bool,
    );

Map<String, dynamic> _$DeskToJson(Desk instance) => <String, dynamic>{
      'id': instance.id,
      'floor': instance.floor,
      'secondMonitor': instance.secondMonitor,
    };
