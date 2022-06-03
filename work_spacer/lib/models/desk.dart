import 'package:flutter/foundation.dart';
import 'package:work_spacer/models/workspace.dart';

@immutable
class Desk extends Workspace{
  final bool secondMonitor;

  const Desk({
    required super.id,
    required super.floor,
    required this.secondMonitor,
  });
}
