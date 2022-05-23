import 'package:flutter/foundation.dart';

@immutable
class Room {
  final int id;
  final int floor;
  final int capacity;
  final bool hasProjector;
  final bool hasWhiteboard;
  final bool hasTeleconference;

  const Room({
    required this.id,
    required this.floor,
    required this.capacity,
    required this.hasProjector,
    required this.hasWhiteboard,
    required this.hasTeleconference,
  });
}
