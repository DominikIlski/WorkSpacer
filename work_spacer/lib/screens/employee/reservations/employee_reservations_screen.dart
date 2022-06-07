import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/stores/cancel_store.dart';
import 'components/employee_reservation_list_item.dart';

class EmployeeReservationsScreen extends StatelessWidget {
  static const routeName = '/my_reservations';

  const EmployeeReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cancelStore = Provider.of<CancelStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My reservations'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: Observer(
                builder: (_) => cancelStore.inProgress
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: cancelStore.filteredReservations.length,
                        itemBuilder: (context, index) =>
                            EmployeeReservationListItem(
                          reservation: cancelStore.filteredReservations[index],
                          onCancel: () => _cancelReservation(
                            context,
                            cancelStore.cancel,
                            cancelStore.filteredReservations[index],
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
    Function(Reservation) cancel,
    Reservation reservation,
  ) {
    FocusManager.instance.primaryFocus?.unfocus();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Do you want to cancel?',
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'confirm'),
            child: Text(
              'Yes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          ),
        ],
      ),
    ).then((result) {
      if (result == 'confirm') {
        cancel(reservation);
      }
    });
  }
}
