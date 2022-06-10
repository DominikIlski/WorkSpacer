import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/desk_reservation.dart';
import 'package:work_spacer/models/notification.dart';
import 'package:work_spacer/models/room.dart';
import 'package:work_spacer/models/room_reservation.dart';

part 'notification_store.g.dart';

class NotificationStore = _NotificationStore with _$NotificationStore;

abstract class _NotificationStore with Store {
  @observable
  bool inProgress = false;

  @observable
  ObservableList<Notification>? _notifications;

  @computed
  ObservableList<Notification> get notifications =>
      ObservableList.of((_notifications ?? []));

  @action
  fetchNotifications() async {
    inProgress = true;
    //TODO handle backend
    await Future.delayed(const Duration(milliseconds: 500));
    _notifications = ObservableList.of(
      notificationsDummy
        ..sort(
          (notification1, notification2) =>
              notification1.compareTo(notification2),
        ),
    );
    inProgress = false;
  }

  @action
  readNotifications() {
    _notifications?.forEach((notification) {
      if (notification.isNew) {
        notification.readNotification();
      }
    });
  }
}

final List<Notification> notificationsDummy = [
  Notification(
    reservation: DeskReservation(
      desk: const Desk(id: 1, floor: 1, secondMonitor: true),
      id: 111,
      startDate: DateTime(2022, 06, 19),
      duration: 6,
      idEmployee: 1,
    ),
    isNew: true,
    replacements: const [],
  ),
  Notification(
    reservation: RoomReservation(
      room: const Room(
        id: 1,
        floor: 2,
        capacity: 20,
        hasProjector: true,
        hasWhiteboard: false,
        hasTeleconference: false,
      ),
      id: 1,
      startDate: DateTime(2022, 06, 14),
      duration: 8,
      idEmployee: 1,
    ),
    isNew: false,
    replacements: const [
      Room(
        id: 2,
        floor: 1,
        capacity: 24,
        hasProjector: true,
        hasWhiteboard: false,
        hasTeleconference: false,
      ),
      Room(
        id: 4,
        floor: 13,
        capacity: 20,
        hasProjector: true,
        hasWhiteboard: true,
        hasTeleconference: true,
      ),
      Room(
        id: 4,
        floor: 13,
        capacity: 20,
        hasProjector: true,
        hasWhiteboard: true,
        hasTeleconference: true,
      ),
      Room(
        id: 4,
        floor: 13,
        capacity: 20,
        hasProjector: true,
        hasWhiteboard: true,
        hasTeleconference: true,
      ),
    ],
  ),
];
