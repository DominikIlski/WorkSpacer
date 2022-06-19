// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'desk_blockage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeskBlockage _$DeskBlockageFromJson(Map<String, dynamic> json) => DeskBlockage(
      desk: Desk.fromJson(json['desk'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$DeskBlockageToJson(DeskBlockage instance) =>
    <String, dynamic>{
      'desk': instance.desk,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };
