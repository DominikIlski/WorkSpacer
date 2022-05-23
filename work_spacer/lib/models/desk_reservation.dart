import 'package:flutter/foundation.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/reservation.dart';

@immutable
class DeskReservation extends Reservation {
  final Desk desk;

  const DeskReservation({
    required this.desk,
    required super.startDate,
    required super.duration,
    required super.idEmployee,
  });
}
