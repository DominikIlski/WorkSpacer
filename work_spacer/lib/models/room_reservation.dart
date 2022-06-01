import 'package:flutter/foundation.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/models/room.dart';

@immutable
class RoomReservation extends Reservation {
  final Room room;


  const RoomReservation({
    required this.room,
    required super.startDate,
    required super.duration,
    required super.idEmployee,
  });
}
