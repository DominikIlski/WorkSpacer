// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/docs/cookbook/testing/unit/introduction

import 'package:flutter_test/flutter_test.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/stores/block_store.dart';
import 'package:work_spacer/stores/desks_store.dart';
import 'package:work_spacer/stores/reservation_store.dart';

void main() {
  group('Desks tests', () {
    test('fetch', () async {
      final desksStore = DesksStore();
      await desksStore.fetchDesks();

      expect(desksStore.desks.isNotEmpty, true);
    });
    test('filter by floor 1', () async {
      final desksStore = DesksStore();
      await desksStore.fetchDesks();
      desksStore.filterStore.toggleValueFilter(FilterParameter.floor, '1');
      var isTrue = desksStore.desks.every((element) => element.floor == 1);
      expect(isTrue, true);
    });
    test('floor filter remove', () async {
      final desksStore = DesksStore();
      await desksStore.fetchDesks();
      int initialListLength = desksStore.desks.length;
      desksStore.filterStore.toggleValueFilter(FilterParameter.floor, '1');
      desksStore.filterStore.resetFilter(FilterParameter.floor);
      expect(desksStore.desks.length, initialListLength);
    });
    test('filter by second monitor', () async {
      final desksStore = DesksStore();
      await desksStore.fetchDesks();
      desksStore.filterStore.toggleSimpleFilter(FilterParameter.secondMonitor);
      var isTrue = desksStore.desks.every((element) => element.secondMonitor == true);
      expect(isTrue, true);
    });
  });
  group('reservation tests', () {
    test('fetch', () async {
      final deskResStore = ReservationStore();
      await deskResStore.fetchReservations();

      expect(deskResStore.reservations.isNotEmpty, true);
    });
    test('cancel reservation', () async {
      final deskResStore = ReservationStore();
      await deskResStore.fetchReservations();
      int initialListLength = deskResStore.reservations.length;
      deskResStore.cancel(deskResStore.reservations.first);
      expect(deskResStore.reservations.length, initialListLength-1);
    });
  });
}
