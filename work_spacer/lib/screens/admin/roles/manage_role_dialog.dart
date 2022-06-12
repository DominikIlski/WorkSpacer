import 'package:flutter/material.dart';
import 'package:work_spacer/i18n.dart';
import 'package:work_spacer/models/user.dart';

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
    return AlertDialog(
      title: Text(
        translate.editRole,
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
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              iconColor: Theme.of(context).primaryColorDark,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorDark,
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
            translate.cancel,
            style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onEditRole(widget.user, _role!);
            Navigator.pop(context);
          },
          child: Text(
            translate.confirm,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
