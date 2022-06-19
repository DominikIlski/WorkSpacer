import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_spacer/models/room.dart';

part 'room_blockage.g.dart';


@immutable
@JsonSerializable()
class RoomBlockage {
  final Room room;
  final DateTime startDate;
  final DateTime endDate;

  const RoomBlockage({
    required this.room,
    required this.startDate,
    required this.endDate,
  });
    factory RoomBlockage.fromJson(Map<String, dynamic> json) => _$RoomBlockageFromJson(json);
  Map<String, dynamic> toJson() => _$RoomBlockageToJson(this);
}
