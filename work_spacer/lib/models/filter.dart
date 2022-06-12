import 'package:flutter/material.dart';
import 'package:work_spacer/i18n.dart';

@immutable
class Filter {
  final FilterParameter parameter;
  final FilterDataType dataType;
  final String title;

  const Filter({
    required this.parameter,
    required this.dataType,
    required this.title,
  });
}

enum FilterParameter {
  id,
  floor,
  date,
  time,
  duration,
  secondMonitor,
  projector,
  whiteboard,
  teleconference,
  capacity,
  name,
  surname,
}

enum FilterDataType {
  number,
  date,
  time,
  simple,
  text,
}

const Map<FilterParameter, FilterDataType> filterParameterDataTypes = {
  FilterParameter.id: FilterDataType.number,
  FilterParameter.floor: FilterDataType.number,
  FilterParameter.date: FilterDataType.date,
  FilterParameter.time: FilterDataType.time,
  FilterParameter.duration: FilterDataType.number,
  FilterParameter.secondMonitor: FilterDataType.simple,
  FilterParameter.projector: FilterDataType.simple,
  FilterParameter.whiteboard: FilterDataType.simple,
  FilterParameter.teleconference: FilterDataType.simple,
  FilterParameter.capacity: FilterDataType.number,
  FilterParameter.name: FilterDataType.text,
  FilterParameter.surname: FilterDataType.text,
};

final Map<FilterParameter, String> filterParameterNames = {
  FilterParameter.id: translate.id,
  FilterParameter.floor: translate.floor,
  FilterParameter.date: translate.date,
  FilterParameter.time: translate.time,
  FilterParameter.duration: translate.duration,
  FilterParameter.secondMonitor: translate.monitor,
  FilterParameter.projector: translate.projector,
  FilterParameter.whiteboard: translate.whiteboard,
  FilterParameter.teleconference: translate.teleconf,
  FilterParameter.capacity: translate.capacity,
  FilterParameter.name: translate.name,
  FilterParameter.surname: translate.surname,
};
