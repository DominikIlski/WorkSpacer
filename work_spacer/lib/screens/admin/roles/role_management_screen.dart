import 'package:flutter/material.dart';
import 'package:work_spacer/models/user.dart';

import '../../components/filter_button.dart';
import '../block/components/search_dialog.dart';
import 'components/manage_role_dialog.dart';
import 'components/user_list_item.dart';

enum SearchParameter { ID, Name, Surname }

class RoleManagementScreen extends StatefulWidget {
  static const routeName = '/roles';

  const RoleManagementScreen({super.key});

  @override
  State<RoleManagementScreen> createState() => _RoleManagementScreenState();
}

class _RoleManagementScreenState extends State<RoleManagementScreen> {
  int _searchParameter = -1;
  SearchParameter _searchType = SearchParameter.ID;
  bool _searchId = false;
  bool _searchName = false;
  bool _searchSurname = false;

  final List<User> users = [
    User(
      name: "John",
      surname: "Kowalsky",
      role: Role.Senior,
    ),
    User(
      name: "Mark",
      surname: "Zucker",
      role: Role.Intern,
    ),
    User(
      name: "Donna",
      surname: "Paulsen",
      role: Role.Executive,
    ),
    User(
      name: "Chris P.",
      surname: "Bacon",
      role: Role.Mid,
    ),
  ];

    void _showManageRoleDialog(BuildContext context, User user, int userIndex) {
    showDialog(
      context: context,
      builder: (context) => ManageRoleDialog(
        user: user,
        userIndex: userIndex,
        onEditRole: onEditRole,
      ),
    ).then((result) {
      if (result == 'confirm') {}
    });
  }

  void onEditRole(Role role, int userIndex) {
    setState(() {
      users[userIndex].role = role;
    });
  }

  void _setSearchParameter(int value, SearchParameter type) {
    setState(() {
      _searchParameter = value;
      _searchType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage roles'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilterButton(
                    icon: Icons.numbers_rounded,
                    text: SearchParameter.ID.name,
                    onClicked: () => {},
                    selected: _searchId,
                  ),
                  const SizedBox(width: 8),
                  FilterButton(
                    icon: Icons.looks_one_outlined,
                    text: SearchParameter.Name.name,
                    onClicked: () => {},
                    selected: _searchName,
                  ),
                  const SizedBox(width: 8),
                  FilterButton(
                    icon: Icons.looks_two_outlined,
                    text: SearchParameter.Surname.name,
                    onClicked: () => {},
                    selected: _searchSurname,
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(
              height: 1,
              thickness: 0.6,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) => UserListItem(
                  user: users[index],
                  onEditClicked: () => _showManageRoleDialog(context, users[index], index),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
