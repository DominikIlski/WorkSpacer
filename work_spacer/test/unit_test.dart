// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/docs/cookbook/testing/unit/introduction

import 'package:flutter_test/flutter_test.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/models/user.dart';
import 'package:work_spacer/stores/desks_store.dart';
import 'package:work_spacer/stores/reservation_store.dart';
import 'package:work_spacer/stores/role_management_store.dart';
import 'package:work_spacer/stores/rooms_store.dart';

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
      var isTrue =
          desksStore.desks.every((element) => element.secondMonitor == true);
      expect(isTrue, true);
    });
  });

  group('Room tests', () {
    test('fetch', () async {
      final roomsStore = RoomsStore();
      await roomsStore.fetchRooms();

      expect(roomsStore.rooms.isNotEmpty, true);
    });
    test('filter by capacity >20', () async {
      final roomsStore = RoomsStore();
      await roomsStore.fetchRooms();
      roomsStore.filterStore.toggleValueFilter(FilterParameter.capacity, '21');
      var isTrue = roomsStore.rooms.every((element) => element.capacity > 20);
      expect(isTrue, true);
    });
    test('floor filter remove', () async {
      final roomsStore = RoomsStore();
      await roomsStore.fetchRooms();
      int initialListLength = roomsStore.rooms.length;
      roomsStore.filterStore.toggleValueFilter(FilterParameter.floor, '1');
      roomsStore.filterStore.resetFilter(FilterParameter.floor);
      expect(roomsStore.rooms.length, initialListLength);
    });
    test('filter by projector', () async {
      final roomsStore = RoomsStore();
      await roomsStore.fetchRooms();
      roomsStore.filterStore.toggleSimpleFilter(FilterParameter.projector);
      var isTrue =
          roomsStore.rooms.every((element) => element.projector == true);
      expect(isTrue, true);
    });
  });

  group('reservation tests', () {
    test('fetch', () async {
      final deskResStore = ReservationStore();
      await deskResStore.fetchReservations(2);

      expect(deskResStore.reservations.isNotEmpty, true);
    });
    test('cancel reservation', () async {
      final deskResStore = ReservationStore();
      await deskResStore.fetchReservations(2);
      int initialListLength = deskResStore.reservations.length;
      deskResStore.cancel(deskResStore.reservations.first);
      expect(deskResStore.reservations.length, initialListLength - 1);
    });
  });

  group('user tests', () {
    test('fetch', () async {
      final roleMagStore = RoleManagementStore();
      await roleMagStore.fetchUsers();

      expect(roleMagStore.users.isNotEmpty, true);
    });
    test('change role', () async {
      final roleMagStore = RoleManagementStore();
      await roleMagStore.fetchUsers();
      int index = 0;
      if (roleMagStore.users[index].role == Role.senior) {
        index++;
      } else {
        roleMagStore.users[index].setRole(Role.senior);
      }

      expect(roleMagStore.users[index].role, Role.senior);
    });
  });
}
