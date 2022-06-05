import 'package:flutter/material.dart';

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
  secondMonitor,
  projector,
  whiteboard,
  teleconference,
  capacity,
}

enum FilterDataType {
  number,
  date,
  simple,
}

const Map<FilterParameter, FilterDataType> filterParameterDataTypes = {
  FilterParameter.id: FilterDataType.number,
  FilterParameter.floor: FilterDataType.number,
  FilterParameter.date: FilterDataType.date,
  FilterParameter.time: FilterDataType.number,
  FilterParameter.secondMonitor: FilterDataType.simple,
  FilterParameter.projector: FilterDataType.simple,
  FilterParameter.whiteboard: FilterDataType.simple,
  FilterParameter.teleconference: FilterDataType.simple,
  FilterParameter.capacity: FilterDataType.simple,
};

const Map<FilterParameter, String> filterParameterNames = {
  FilterParameter.id: 'ID',
  FilterParameter.floor: 'Floor',
  FilterParameter.date: 'Date',
  FilterParameter.time: 'Time',
  FilterParameter.secondMonitor: 'Extra monitor',
  FilterParameter.projector: 'Projector',
  FilterParameter.whiteboard: 'Whiteboard',
  FilterParameter.teleconference: 'Teleconference system',
  FilterParameter.capacity: 'Capacity',
};
