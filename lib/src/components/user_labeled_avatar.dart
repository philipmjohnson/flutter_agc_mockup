import 'package:flutter/material.dart';
import '../data_model/user_db.dart';

/// Returns a CircleAvatar with either an image if available or initials, plus a label.
class UserLabeledAvatar extends StatelessWidget {
  const UserLabeledAvatar({Key? key, required String this.userID, String this.label = '', double this.rightPadding = 0}) : super(key: key);

  final String userID;
  final String label;
  final double rightPadding;

  @override
  Widget build(BuildContext context) {
    UserData data = userDB.getUser(userID);
    bool hasImagePath = data.imagePath != null;
    return Row(
      children: [
        Column(children: [
          (hasImagePath) ?
          CircleAvatar(
            backgroundImage: AssetImage(data.imagePath!),
          ):
          CircleAvatar(
            child: Text(data.initials),
          ),
          Text(this.label)
        ]),
        SizedBox(width: this.rightPadding)
      ],
    );
  }
}
