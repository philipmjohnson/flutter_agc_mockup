import 'package:flutter/material.dart';

import '../../components/user_avatar.dart';
import '../../data_model/user_db.dart';

class UserCardView extends StatelessWidget {
  const UserCardView({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  Widget build(BuildContext context) {
    UserData data = userDB.getUser(userID);
    return Card(
        child: Column(
          children: [
            ListTile(
                leading: UserAvatar(userID: userID),
                trailing: const Icon(Icons.more_vert),
                title: Text(data.username,
                    style: Theme.of(context).textTheme.headline6)),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Align(alignment: Alignment.centerLeft, child: Text('Gardens2: xxx')),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Align(alignment: Alignment.centerLeft, child: Text('Chapters: xxx')),
            ),
          ],
        ));
  }
}
