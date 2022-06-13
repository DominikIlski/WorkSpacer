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
    final theme = Theme.of(context);
    return Observer(
      builder: (_) => Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                Icons.account_circle_outlined,
                color: theme.colorScheme.tertiary,
                size: 36,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${user.name} ${user.surname}",
                    style: theme.textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.manage_accounts_outlined,
                        color: theme.colorScheme.tertiary,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        roleNames[user.role]!,
                        style: theme.textTheme.bodyText1,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
