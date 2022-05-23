import 'package:flutter/foundation.dart';
import 'package:work_spacer/models/desk.dart';

@immutable
class DeskBlockage {
  final Desk desk;
  final DateTime startDate;
  final DateTime endDate;

  const DeskBlockage({
    required this.desk,
    required this.startDate,
    required this.endDate,
  });
}
