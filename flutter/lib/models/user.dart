import 'dart:convert';
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
    required this.shopId,
  });
  final int id;
  final String email;
  final String name;
  // final String nickname;
  final String role;
  final String phoneNumber;
  final String jwt;
  final int shopId;
  List<Cart> Carts = [];
}

class Cart {
  int count;
  int price;
  String menu;

  Cart({required this.menu, required this.price, required this.count});

// (:payment).permit(:price, :status, :customer_id, :host_id, :name

  String toJson(int customerId, int hostId) {
    var body = json.encode({
      "payment": {
        "price": price,
        "name": menu,
        "status": "paid",
        "customer_id": customerId,
        "host_id": hostId,
      }
    });
    return body;
  }
}
