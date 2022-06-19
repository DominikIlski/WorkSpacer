import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';


@immutable
abstract class Reservation {
  final int id;
  final DateTime startDate;
  final int duration;
  @JsonKey(fromJson: _employeeFromJson)
  final int idEmployee;

  const Reservation({
    required this.id,
    required this.startDate,
    required this.duration,
    required this.idEmployee,
  });

  bool get canceled => false;
}



int _employeeFromJson(dynamic data) {
  var json = Map<String, dynamic>.from(data);
  return json['data']['id'];
}