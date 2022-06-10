import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/user.dart';

class ManageRoleDialog extends StatefulWidget {
  ManageRoleDialog({
    Key? key,
    required this.user,
    required this.userIndex,
    required this.onEditRole,
  }) : super(key: key);

  final User user;
  final int userIndex;
  final Function(Role role, int userIndex) onEditRole;

  @override
  State<ManageRoleDialog> createState() => _ManageRoleDialog();
}

class _ManageRoleDialog extends State<ManageRoleDialog> {
  Role? _role;

  @override
  Widget build(BuildContext context) {
    _role = widget.user.role;

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
                  width: 2.0,
                  color: Theme.of(context).primaryColorDark,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              iconColor: Theme.of(context).primaryColorDark,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: Theme.of(context).primaryColorDark,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            value: widget.user.role,
            items: Role.values
                .map(
                  (role) => DropdownMenuItem<Role>(
                    child: Text(
                      role.name,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    value: role,
                  ),
                ).toList(),
            onChanged: (Role? value) {
              setState(() {
                _role = value;
              });
            },
          ),
          SizedBox(height: 16),
          RaisedButton(
            onPressed: () {
              widget.onEditRole(
                _role!,
                widget.userIndex,
              );
              Navigator.pop(context, 'confirm');
            },
            color: Theme.of(context).secondaryHeaderColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.all(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Edit role',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
