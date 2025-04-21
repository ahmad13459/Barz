class TransactionModel {
  final int? id;
  final int customerId;
  final double amount;
  final String type; // 'credit' or 'debit'

  TransactionModel({
    this.id,
    required this.customerId,
    required this.amount,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'amount': amount,
      'type': type,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      customerId: map['customerId'],
      amount: map['amount'],
      type: map['type'],
    );
  }
}

