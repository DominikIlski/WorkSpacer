import 'package:flutter/material.dart';

@immutable
abstract class Workspace {
  final int id;
  final int floor;

  const Workspace({
    required this.id,
    required this.floor,
  });
}
