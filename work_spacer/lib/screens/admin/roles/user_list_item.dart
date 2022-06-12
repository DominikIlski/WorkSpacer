import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:work_spacer/i18n.dart';
import 'package:work_spacer/models/user.dart';

class UserListItem extends StatelessWidget {
  final User user;
  final VoidCallback onEditClicked;

  const UserListItem({
    super.key,
    required this.user,
    required this.onEditClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Card(
        color: Theme.of(context).primaryColorLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Theme.of(context).primaryColorDark),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.account_circle_outlined,
                color: Theme.of(context).primaryColor,
                size: 32,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${user.name} ${user.surname}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.manage_accounts_outlined,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        roleNames[user.role]!,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: onEditClicked,
                label: Text(translate.edit),
                icon: const Icon(Icons.edit_outlined),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).secondaryHeaderColor,
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
