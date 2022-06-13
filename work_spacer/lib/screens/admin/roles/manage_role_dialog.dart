import 'package:flutter/material.dart';
import 'package:work_spacer/models/user.dart';
import 'package:work_spacer/screens/widgets/keyboard_hide_wrapper.dart';

class ManageRoleDialog extends StatefulWidget {
  const ManageRoleDialog({
    Key? key,
    required this.user,
    required this.onEditRole,
  }) : super(key: key);

  final User user;
  final Function(User user, Role role) onEditRole;

  @override
  State<ManageRoleDialog> createState() => _ManageRoleDialog();
}

class _ManageRoleDialog extends State<ManageRoleDialog> {
  Role? _role;

  @override
  void initState() {
    super.initState();
    _role = widget.user.role;
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusWrapper(
      child: AlertDialog(
        title: const Text('Edit role'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField(
              value: _role,
              isDense: false,
              isExpanded: true,
              items: Role.values
                  .map(
                    (role) => DropdownMenuItem<Role>(
                      child: Text(
                        roleNames[role]!,
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      value: role,
                    ),
                  )
                  .toList(),
              onChanged: (Role? value) {
                setState(() {
                  _role = value;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onEditRole(widget.user, _role!);
              Navigator.pop(context);
            },
            child: const Text(
              'Confirm',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
