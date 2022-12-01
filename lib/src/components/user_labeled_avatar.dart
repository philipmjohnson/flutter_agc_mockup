import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/components/user_avatar.dart';
import '../data_model/user_db.dart';

/// Returns a CircleAvatar with either an image if available or initials, plus a label.
class UserLabeledAvatar extends StatelessWidget {
  const UserLabeledAvatar(
      {Key? key,
      required String this.userID,
      String this.label = '',
      double this.rightPadding = 0})
      : super(key: key);

  final String userID;
  final String label;
  final double rightPadding;

  @override
  Widget build(BuildContext context) {
    UserData data = userDB.getUser(userID);
    return Row(
      children: [
        Column(children: [UserAvatar(userID: userID), Text(label)]),
        SizedBox(width: rightPadding)
      ],
    );
  }
}
