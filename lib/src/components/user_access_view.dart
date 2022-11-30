import 'package:flutter/material.dart';
import '../data/user/user_db.dart';

/// Returns a CircleAvatar with either an image if available or initials, plus a label.
class UserAccessView extends StatelessWidget {
  const UserAccessView({Key? key, required String this.userID, required String this.label}) : super(key: key);

  final String userID;
  final String label;

  @override
  Widget build(BuildContext context) {
    UserData data = userDB.getUser(userID);
    bool hasImagePath = data.imagePath != null;
    return Column(children: [
      (hasImagePath) ?
      CircleAvatar(
        backgroundImage: AssetImage(data.imagePath!),
      ):
      CircleAvatar(
        child: Text(data.initials),
      ),
      Text(this.label),
    ]);
  }
}
