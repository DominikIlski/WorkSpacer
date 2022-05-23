import 'package:flutter/foundation.dart';
import 'package:work_spacer/models/room.dart';

@immutable
class RoomBlockage {
  final Room room;
  final DateTime startDate;
  final DateTime endDate;

  const RoomBlockage({
    required this.room,
    required this.startDate,
    required this.endDate,
  });
}
