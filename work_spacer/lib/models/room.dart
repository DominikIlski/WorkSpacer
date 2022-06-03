import 'package:flutter/foundation.dart';
import 'package:work_spacer/models/workspace.dart';

@immutable
class Room extends Workspace {
  final int capacity;
  final bool hasProjector;
  final bool hasWhiteboard;
  final bool hasTeleconference;

  const Room({
    required super.id,
    required super.floor,
    required this.capacity,
    required this.hasProjector,
    required this.hasWhiteboard,
    required this.hasTeleconference,
  });
}
