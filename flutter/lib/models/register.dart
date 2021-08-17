import 'dart:convert';

class Register {
  final String email;
  final String name;
  final String nickname;
  final String role;
  final String phoneNumber;
  final String password;
  final String passwordConfirmation;

  Register({
    required this.email,
    required this.name,
    required this.nickname,
    required this.role,
    required this.phoneNumber,
    required this.password,
    required this.passwordConfirmation,
  });

  String toJson() {
    var body = {
      "email": email,
      "name": name,
      "nickname": nickname,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "phone_number": phoneNumber,
      "role": role,
    };

    var user = {};
    user["user"] = body;
    return json.encode(user);
  }
}
