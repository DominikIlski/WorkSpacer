import 'package:flutter/foundation.dart';

@immutable
abstract class Reservation {
  final DateTime startDate;
  final int duration;
  final int idEmployee;

  const Reservation({
    required this.startDate,
    required this.duration,
    required this.idEmployee,
  });
}
