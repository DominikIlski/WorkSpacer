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

const Map<FilterParameter, String> filterParameterNames = {
  FilterParameter.id: 'ID',
  FilterParameter.floor: 'Floor',
  FilterParameter.date: 'Date',
  FilterParameter.time: 'Time',
  FilterParameter.duration: 'Duration',
  FilterParameter.secondMonitor: 'Extra monitor',
  FilterParameter.projector: 'Projector',
  FilterParameter.whiteboard: 'Whiteboard',
  FilterParameter.teleconference: 'Teleconference system',
  FilterParameter.capacity: 'Capacity',
  FilterParameter.name: 'Name',
  FilterParameter.surname: 'Surname',
};
