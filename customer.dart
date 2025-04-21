class Customer {
  final int? id;
  final String name;
  final double balance;

  Customer({this.id, required this.name, required this.balance});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      balance: map['balance'],
    );
  }
}

