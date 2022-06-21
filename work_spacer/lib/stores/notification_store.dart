import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/desk_reservation.dart';
import 'package:work_spacer/models/notification.dart';
import 'package:work_spacer/models/room.dart';
import 'package:work_spacer/models/room_reservation.dart';
import 'package:work_spacer/src/helpers/proxy.dart';

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

    var res = await Proxy.data('notifications');
    var jsonNotifi = res['data'].map((e) {
      return <String, dynamic>{"id": e['id'], ...e['attributes']};
    }).toList();

    var notifi = jsonNotifi
        .map<Notification>((e) => Notification.fromJson(e))
        .toList() as List<Notification>;
    _notifications = ObservableList.of(
      notifi
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
        Proxy.data('notifications/${notification.id}',
            method: 'PUT', body: {"isNew": false});
        notification.readNotification();
      }
    });
  }
}

final List<Notification> notificationsDummy = [];
