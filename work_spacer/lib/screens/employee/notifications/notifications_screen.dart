import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/models/desk_reservation.dart';
import 'package:work_spacer/screens/employee/notifications/notification_list_item.dart';
import 'package:work_spacer/stores/desks_store.dart';
import 'package:work_spacer/stores/notification_store.dart';
import 'package:work_spacer/models/notification.dart' as custom;
import 'package:work_spacer/stores/rooms_store.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifications';

  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<NotificationStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Observer(
                builder: (_) => store.inProgress
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: store.notifications.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: NotificationListItem(
                            notification: store.notifications[index],
                            onReplacementConfirm: _onReplacementConfirm(
                              context,
                              store.notifications[index],
                            ),
                          ),
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onReplacementConfirm(context, custom.Notification notification) {
    if (notification.reservation is DeskReservation) {
      final desksStore = Provider.of<DesksStore>(context, listen: false);
      return desksStore.reserveDesk;
    } else {
      final roomsStore = Provider.of<RoomsStore>(context, listen: false);
      return roomsStore.reserveRoom;
    }
  }
}
