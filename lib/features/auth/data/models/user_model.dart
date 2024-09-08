import 'package:blog_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }

  UserModel copyWith({String? id, String? name, String? email}) {
    return UserModel(
        id: id ?? this.id, email: email ?? this.email, name: name ?? this.name);
  }
}
