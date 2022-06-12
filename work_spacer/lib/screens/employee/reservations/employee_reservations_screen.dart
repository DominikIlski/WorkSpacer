import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/i18n.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/screens/widgets/reservation_list_item.dart';
import 'package:work_spacer/stores/reservation_store.dart';

class EmployeeReservationsScreen extends StatelessWidget {
  static const routeName = '/my_reservations';

  const EmployeeReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ReservationStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(translate.myRes),
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
                        itemCount: store.reservations.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: ReservationListItem(
                            reservation: store.reservations[index],
                            onCancel: () => _cancelReservation(
                              context,
                              store.cancel,
                              store.reservations[index],
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

  void _cancelReservation(
    context,
    Function(Reservation) onCancel,
    Reservation reservation,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          translate.cancelQ,
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(translate.no),
          ),
          TextButton(
            onPressed: () {
              onCancel(reservation);
              Navigator.pop(context);
            },
            child: Text(
              translate.yes,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
