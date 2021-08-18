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
      id: json['id'],
      name: json['name'],
      price: json['price'],
      status: json['status'],
      hostId: json['hostId'],
      customerId: json['customerId'],
    );
  }
}
