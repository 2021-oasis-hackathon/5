class Cart {
  final int id;
  final int menuId;
  final int customerId;
  final int price;
  final int count;

  Cart(
      {required this.id,
      required this.menuId,
      required this.customerId,
      required this.price,
      required this.count});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return new Cart(
      id: json['id'],
      price: json['price'],
      count: json['count'],
      menuId: json['menu_id'],
      customerId: json['customer_id'],
    );
  }
}
