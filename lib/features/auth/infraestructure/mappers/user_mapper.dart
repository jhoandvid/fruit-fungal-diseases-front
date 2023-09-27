import 'package:fruit_fungal_diseases/features/auth/domain/domain.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
      email: json['email'],
      name: json["name"],
      role: json["role"],
      id: json["id"],
      token: json["token"]);
}
