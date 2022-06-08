import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/filter.dart';

part 'filter_store.g.dart';

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  _FilterStore(List<FilterParameter> parameters) {
    filters = ObservableMap.of(
      {
        for (final parameter in parameters) parameter: null,
      },
    );
  }

  @observable
  ObservableMap<FilterParameter, dynamic> filters = ObservableMap.of({});

  @action
  resetFilter(FilterParameter parameter) {
    if (filters.containsKey(parameter)) {
      filters[parameter] = null;
    }
  }

  @action
  toggleSimpleFilter(FilterParameter parameter) {
    if (filters.containsKey(parameter)) {
      if (filters[parameter] != null) {
        filters[parameter] = null;
      } else {
        filters[parameter] = true;
      }
    }
  }

  @action
  toggleValueFilter(FilterParameter parameter, String valueAsString) {
    if (filters.containsKey(parameter)) {
      if (valueAsString.isNotEmpty) {
        dynamic value;
        if (filterParameterDataTypes[parameter] == FilterDataType.number) {
          value = int.tryParse(valueAsString);
        } else if (filterParameterDataTypes[parameter] == FilterDataType.date) {
          try {
            value = DateFormat('dd.MM.yyyy').parse(valueAsString);
          } catch (e) {
            value = null;
          }
        } else if (filterParameterDataTypes[parameter] == FilterDataType.time) {
          try {
            final dateTime = DateFormat.jm().parse(valueAsString);
            value = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
          } catch (e) {
            value = null;
          }
        }
        filters[parameter] = value;
      }
    }
    print(filters);
  }
}
