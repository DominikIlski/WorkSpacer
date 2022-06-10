import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/models/workspace.dart';

part 'notification.g.dart';

class Notification = _Notification with _$Notification;

abstract class _Notification with Store {
  _Notification({
    required this.reservation,
    required this.replacements,
    required this.isNew,
  });

  final Reservation reservation;
  final List<Workspace> replacements;

  @observable
  bool isNew;

  @action
  readNotification() {
    isNew = false;
  }

  int compareTo(Notification other) {
    if (isNew && other.isNew) {
      return reservation.startDate.compareTo(other.reservation.startDate);
    } else if (isNew) {
      return -1;
    } else {
      return 1;
    }
  }
}
