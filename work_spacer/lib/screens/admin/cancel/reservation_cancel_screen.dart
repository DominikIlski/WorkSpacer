import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/screens/widgets/keyboard_hide_wrapper.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/stores/cancel_store.dart';
import '../../widgets/reservation_list_item.dart';

class ReservationCancelScreen extends StatelessWidget {
  static const routeName = '/cancel';

  const ReservationCancelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cancelStore = Provider.of<CancelStore>(context);

    return KeyboardHideWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cancel a reservation'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: _WorkspaceSearchTextField(
                  value: cancelStore.searchWorkspaceId,
                  onChanged: cancelStore.setSearchWorkspaceId,
                ),
              ),
              const SizedBox(height: 16),
              Divider(
                height: 0,
                thickness: 1,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Observer(
                  builder: (_) => cancelStore.inProgress
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: cancelStore.filteredReservations.length,
                          itemBuilder: (context, index) => ReservationListItem(
                            reservation:
                                cancelStore.filteredReservations[index],
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
      ),
    );
  }

  void _cancelReservation(
    context,
    Function(Reservation) onCancel,
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
            onPressed: () {
              onCancel(reservation);
              Navigator.pop(context);
            },
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
    );
  }
}

class _WorkspaceSearchTextField extends StatefulWidget {
  const _WorkspaceSearchTextField({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String value;
  final void Function(String value) onChanged;

  @override
  State<_WorkspaceSearchTextField> createState() =>
      _WorkspaceSearchTextFieldState();
}

class _WorkspaceSearchTextFieldState extends State<_WorkspaceSearchTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _controller.text = widget.value;
    });
    return Observer(
      builder: (_) => TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        onChanged: (value) => widget.onChanged.call(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          hintText: "Workspace ID",
          hintStyle: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        ),
      ),
    );
  }
}
