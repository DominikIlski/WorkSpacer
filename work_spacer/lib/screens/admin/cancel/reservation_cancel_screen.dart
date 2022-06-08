import 'package:flutter/material.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/room.dart';
import 'components/reservation_list_item.dart';
import '../../../models/reservation.dart';
import '../../../models/desk_reservation.dart';
import '../../../models/room_reservation.dart';

class ReservationCancelScreen extends StatefulWidget {
  static const routeName = '/cancel';

  ReservationCancelScreen({super.key});

  @override
  State<ReservationCancelScreen> createState() =>
      _ReservationCancelScreenState();
}

class _ReservationCancelScreenState extends State<ReservationCancelScreen> {
  final TextEditingController searchController = TextEditingController();

  void _removeAtIndex(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you want to cancel?',
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
            )),
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
        setState(() {
          reservations.removeAt(index);
        });
      }
    });
  }

  final List<Reservation> reservations = [
    DeskReservation(
      desk: const Desk(
        id: 23,
        floor: 2,
        secondMonitor: false,
      ),
      startDate: DateTime.now(),
      duration: 3,
      idEmployee: 21,
    ),
    RoomReservation(
      room: const Room(
        id: 15,
        floor: 1,
        capacity: 21,
        hasProjector: true,
        hasWhiteboard: false,
        hasTeleconference: false,
      ),
      startDate: DateTime.now().subtract(const Duration(days: 12)),
      duration: 2,
      idEmployee: 11,
    ),
    DeskReservation(
      desk: const Desk(
        id: 2,
        floor: 2,
        secondMonitor: false,
      ),
      startDate: DateTime.now().subtract(const Duration(days: 2)),
      duration: 7,
      idEmployee: 21,
    ),
    RoomReservation(
      room: const Room(
        id: 111,
        floor: 1,
        capacity: 21,
        hasProjector: true,
        hasWhiteboard: false,
        hasTeleconference: false,
      ),
      startDate: DateTime.now().subtract(const Duration(days: 5)),
      duration: 4,
      idEmployee: 11,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cancel a reservation'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 40,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).primaryColorLight,
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                  hintText: "Desk/Room",
                  hintStyle:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    onPressed:
                        //TODO: implement searching functionality
                        () => {},
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Divider(
              height: 1,
              thickness: 0.6,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (context, index) => ReservationListItem(
                  reservation: reservations[index],
                  onCancelClicked: () => _removeAtIndex(index),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
