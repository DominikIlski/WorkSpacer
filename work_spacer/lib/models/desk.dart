import 'package:flutter/foundation.dart';

@immutable
class Desk {
  final int id;
  final int floor;
  final bool secondMonitor;

  const Desk({
    required this.id,
    required this.floor,
    required this.secondMonitor,
  });
}
