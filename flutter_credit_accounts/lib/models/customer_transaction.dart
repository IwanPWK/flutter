import 'dart:convert';

class CustomerTransaction {
  final int? id;
  final int customerId;
  final double amount;
  final DateTime date;
  final String type;
  final String? description;

  CustomerTransaction({
    this.id,
    required this.customerId,
    required this.amount,
    required this.date,
    required this.type,
    this.description,
  });

  CustomerTransaction copyWith({
    int? id,
    int? customerId,
    double? amount,
    DateTime? date,
    String? type,
    String? description,
  }) {
    return CustomerTransaction(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type,
      'description': description,
    };
  }

  factory CustomerTransaction.fromMap(Map<String, dynamic> map) {
    return CustomerTransaction(
      id: map['id'],
      customerId: map['customerId'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      type: map['type'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerTransaction.fromJson(String source) =>
      CustomerTransaction.fromMap(json.decode(source));
}
