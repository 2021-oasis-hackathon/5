import 'dart:core';

class UserMe {
  UserMe({
    required this.id,
    required this.email,
    required this.name,
    // required this.nickname,
    required this.role,
    required this.phoneNumber,
    required this.jwt,
  });
  final int id;
  final String email;
  final String name;
  // final String nickname;
  final String role;
  final String phoneNumber;
  final String jwt;
  //List<Cart>;
}
