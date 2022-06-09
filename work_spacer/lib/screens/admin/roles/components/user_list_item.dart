import 'package:flutter/material.dart';
import 'package:work_spacer/models/desk_reservation.dart';
import 'package:work_spacer/models/reservation.dart';
import 'package:work_spacer/models/room_reservation.dart';
import 'package:intl/intl.dart';

import '../../../../models/user.dart';

class UserListItem extends StatelessWidget {
  User user;
  VoidCallback onEditClicked;

  UserListItem({
    super.key,
    required this.user,
    required this.onEditClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).primaryColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Theme.of(context).primaryColorDark,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_circle_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 36,
                ),
                SizedBox(width: 16),
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
                    SizedBox(height: 8),
                    Row(children: [
                      Icon(
                        Icons.manage_accounts_outlined,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        user.role.name,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
            RaisedButton(
              color: Theme.of(context).secondaryHeaderColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.all(6),
              child: Row(
                children: const [
                  Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Edit",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              onPressed: onEditClicked,
            ),
          ],
        ),
      ),
    );
  }
}
