import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String username,
    String? imagePath,
    required String initials,
  }) = _User;

  const User._();

  factory User.fromFirestore(Map<String, dynamic> json, String documentId) {
    return User(
        id: documentId,
        name: json['name'],
        username: json['username'],
        imagePath: json['imagePath'],
        initials: json['initials']);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
