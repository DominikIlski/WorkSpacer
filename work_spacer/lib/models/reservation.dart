import 'package:flutter/foundation.dart';

@immutable
abstract class Reservation {
  final int id;
  final DateTime startDate;
  final int duration;
  final int idEmployee;

  const Reservation({
    required this.id,
    required this.startDate,
    required this.duration,
    required this.idEmployee,
  });
}
