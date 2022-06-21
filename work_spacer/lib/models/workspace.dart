import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';


@immutable
abstract class Workspace {
  final int id;
  final int floor;

  const Workspace({
    required this.id,
    required this.floor,
  });

}
