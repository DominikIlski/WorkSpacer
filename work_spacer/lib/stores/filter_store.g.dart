// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilterStore on _FilterStore, Store {
  late final _$filtersAtom =
      Atom(name: '_FilterStore.filters', context: context);

  @override
  ObservableMap<FilterParameter, dynamic> get filters {
    _$filtersAtom.reportRead();
    return super.filters;
  }

  @override
  set filters(ObservableMap<FilterParameter, dynamic> value) {
    _$filtersAtom.reportWrite(value, super.filters, () {
      super.filters = value;
    });
  }

  late final _$_FilterStoreActionController =
      ActionController(name: '_FilterStore', context: context);

  @override
  dynamic resetFilter(FilterParameter parameter) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.resetFilter');
    try {
      return super.resetFilter(parameter);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toggleSimpleFilter(FilterParameter parameter) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.toggleSimpleFilter');
    try {
      return super.toggleSimpleFilter(parameter);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toggleValueFilter(FilterParameter parameter, String valueAsString) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.toggleValueFilter');
    try {
      return super.toggleValueFilter(parameter, valueAsString);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filters: ${filters}
    ''';
  }
}
