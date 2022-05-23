import 'package:flutter/foundation.dart';
import 'package:work_spacer/models/room.dart';

@immutable
class RoomReservation {
  final Room room;
  final DateTime startDate;
  final int duration;
  final int idEmployee;

  const RoomReservation({
    required this.room,
    required this.startDate,
    required this.duration,
    required this.idEmployee,
  });
}
