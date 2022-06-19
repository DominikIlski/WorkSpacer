import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_spacer/models/workspace.dart';

part 'desk.g.dart';

@immutable
@JsonSerializable()
class Desk extends Workspace {
  final bool secondMonitor;

  const Desk({
    required super.id,
    required super.floor,
    required this.secondMonitor,
  });
  factory Desk.fromJson(Map<String, dynamic> json) => _$DeskFromJson(json);
  Map<String, dynamic> toJson() => _$DeskToJson(this);
}
