import 'package:equatable/equatable.dart';

// First Way
// class Person {
//   final int id;
//   final String name;
//   final String email;
//   const Person({required this.id, required this.name, required this.email});

//Third Way
class Person extends Equatable {
  final int id;
  final String name;
  final String email;
  const Person({required this.id, required this.name, required this.email});

  @override
  String toString() => 'Person(id: $id, name: $name, email: $email)';

  Person copyWith({int? id, String? name, String? email}) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  // Second Way
  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is Person &&
  //       other.id == id &&
  //       other.name == name &&
  //       other.email == email;
  // }

  // @override
  // int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;

  //Third Way
  @override
  List<Object> get props => [id, name, email];
}
