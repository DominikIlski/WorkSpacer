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
    //IMPORTANT! Remember to fetch possible replacements!! Let;s say we set a max of 5
    //e.g. when a reservation for desk is cancelled, the notification must be sent and in it there must be a list of max.5 desks that are available the same day time and duration, might be empty
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
        //handle backend notification: isNew -> false
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
        projector: true,
        whiteboard: false,
        teleconferenceSystem: false,
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
        projector: true,
        whiteboard: false,
        teleconferenceSystem: false,
      ),
      Room(
        id: 4,
        floor: 13,
        capacity: 20,
        projector: true,
        whiteboard: true,
        teleconferenceSystem: true,
      ),
      Room(
        id: 4,
        floor: 13,
        capacity: 20,
        projector: true,
        whiteboard: true,
        teleconferenceSystem: true,
      ),
      Room(
        id: 4,
        floor: 13,
        capacity: 20,
        projector: true,
        whiteboard: true,
        teleconferenceSystem: true,
      ),
    ],
  ),
];
