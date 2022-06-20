import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_spacer/models/desk.dart';

part 'desk_blockage.g.dart';

@immutable
@JsonSerializable()
class DeskBlockage {
  final Desk desk;
  final DateTime startDate;
  final DateTime endDate;

  const DeskBlockage({
    required this.desk,
    required this.startDate,
    required this.endDate,
  });
  factory DeskBlockage.fromJson(Map<String, dynamic> json) => _$DeskBlockageFromJson(json);
  Map<String, dynamic> toJson() => _$DeskBlockageToJson(this);
}
