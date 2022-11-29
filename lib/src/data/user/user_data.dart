/// A placeholder for the MemberInfo entity.
class UserData {
  UserData(
      {required this.id, required this.name, this.imagePath, required this.initials});

  String id;
  String name;
  String? imagePath;
  String initials;
}

List<UserData> userDatas = [
  UserData(id: 'user-001',
      name: 'Jenna Deane',
      imagePath: 'assets/images/jenna-deane.jpg',
      initials: 'JD'),
  UserData(id: 'user-002', name: 'Jesse Beck', initials: 'JB'),
  UserData(id: 'user-003', name: 'Joanne Amberg', initials: 'JA')
];
