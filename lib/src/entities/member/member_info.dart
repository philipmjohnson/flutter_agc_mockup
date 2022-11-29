/// A placeholder for the MemberInfo entity.
class MemberInfo {
  MemberInfo({required this.id, required this.name, this.imagePath, required this.initials});
  String id;
  String name;
  String? imagePath;
  String initials;
}

MemberInfo memberJenna = MemberInfo(id: 'jd', name: 'Jenna Deane', imagePath: 'assets/images/jenna-deane.jpg', initials: 'JD');

MemberInfo memberJesse = MemberInfo(id: 'jb', name: 'Jesse Beck', initials: 'JB');

MemberInfo memberJoanne = MemberInfo(id: 'ja', name: 'Joanne Amberg', initials: 'JA');
