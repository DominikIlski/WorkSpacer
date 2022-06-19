import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_spacer/models/workspace.dart';

part 'room.g.dart';

@JsonSerializable()
@immutable
class Room extends Workspace {
  final int capacity;
  final bool projector;
  final bool whiteboard;
  final bool teleconferenceSystem;

  const Room({
    required super.id,
    required super.floor,
    required this.capacity,
    required this.projector,
    required this.whiteboard,
    required this.teleconferenceSystem,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
