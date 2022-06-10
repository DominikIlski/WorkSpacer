import 'package:flutter/material.dart';

import '../../../../models/user.dart';

class ManageRoleDialog extends StatefulWidget {
  const ManageRoleDialog({
    Key? key,
    required this.currentRole,
    required this.onEditRole,
  }) : super(key: key);

  final Role currentRole;
  final Function(Role role) onEditRole;

  @override
  State<ManageRoleDialog> createState() => _ManageRoleDialog();
}

class _ManageRoleDialog extends State<ManageRoleDialog> {
  Role? _role;

  @override
  void initState() {
    super.initState();
    _role = widget.currentRole;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Edit role',
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorDark,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              iconColor: Theme.of(context).primaryColorDark,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorDark,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            value: _role,
            items: Role.values
                .map(
                  (role) => DropdownMenuItem<Role>(
                    child: Text(
                      roleNames[role]!,
                      style: TextStyle(color: Theme.of(context).primaryColor),
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
          child: Text(
            'Cancel',
            style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onEditRole(_role!);
            Navigator.pop(context);
          },
          child: const Text(
            'Confirm',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
