import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/i18n.dart';
import 'package:work_spacer/screens/widgets/keyboard_hide_wrapper.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/stores/authentication_store.dart';
import 'package:work_spacer/stores/cancel_store.dart';
import '../../widgets/reservation_list_item.dart';

class ReservationCancelScreen extends StatelessWidget {
  static const routeName = '/cancel';

  const ReservationCancelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cancelStore = Provider.of<CancelStore>(context);
    final user = Provider.of<AuthenticationStore>(context);
    return UnfocusWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text(translate.cancelRes),
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
              const Divider(),
              const SizedBox(height: 16),
              Expanded(
                child: Observer(
                  builder: (_) => cancelStore.inProgress
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: cancelStore.filteredReservations.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: ReservationListItem(
                              reservation:
                                  cancelStore.filteredReservations[index],
                              onCancel: () => _cancelReservation(
                                context,
                                cancelStore.cancel,
                                cancelStore.filteredReservations[index],
                                user.userId!
                              ),
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
    Function(Reservation, int) onCancel,
    Reservation reservation,
    int adminId
  ) {
    FocusManager.instance.primaryFocus?.unfocus();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(translate.cancelQ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(translate.no),
          ),
          TextButton(
            onPressed: () {
              onCancel(reservation, adminId);
              Navigator.pop(context);
            },
            child: Text(
              translate.yes,
              style: const TextStyle(fontWeight: FontWeight.bold),
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
        keyboardType: const TextInputType.numberWithOptions(),
        onChanged: (value) => widget.onChanged.call(value),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
        ],
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          labelText: translate.wsID,
        ),
      ),
    );
  }
}
