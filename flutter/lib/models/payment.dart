class Payment {
  final int id;
  final int hostId;
  final int customerId;
  final int price;
  final String status;
  final String name;

  Payment({
    required this.id,
    required this.hostId,
    required this.customerId,
    required this.price,
    required this.status,
    required this.name,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return new Payment(
      id: int.parse(json['id']),
      name: json['name'],
      price: int.parse(json['price']),
      status: json['status'],
      hostId: int.parse(json['hostId']),
      customerId: int.parse(json['customerId']),
    );
  }
}
