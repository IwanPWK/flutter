import 'dart:convert';

class Customer {
  final int? id;
  final String name;
  final DateTime created;
  final double youllGet; // you'll get from customer
  final double youllGive; // you'll give from customer

  Customer({
    this.id,
    required this.name,
    required this.created,
    required this.youllGet,
    required this.youllGive,
  });

  Customer copyWith({
    int? id,
    String? name,
    DateTime? created,
    double? youllGet,
    double? youllGive,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      created: created ?? this.created,
      youllGet: youllGet ?? this.youllGet,
      youllGive: youllGive ?? this.youllGive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'created': created.toIso8601String(),
      'youllGet': youllGet,
      'youllGive': youllGive,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      created: DateTime.parse(map['created']),
      youllGet: map['youllGet'],
      youllGive: map['youllGive'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));
}
