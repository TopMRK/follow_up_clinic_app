import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final String email;
  final String password;
  final String telephone;
  final String firstname;
  final String lastname;
  final DateTime birthday;
  final String hn;
  final String address;

  const Register(
      {required this.email,
      required this.password,
      required this.telephone,
      required this.firstname,
      required this.lastname,
      required this.birthday,
      required this.hn,
      required this.address});

  @override
  List<Object> get props => [
        {email}
      ];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'telephone': telephone,
      'firstname': firstname,
      'lastname': lastname,
      'birthday': birthday,
      'hn': hn,
      'address': address,
      'role': 'user',
      'created_at': DateTime.now(),
      'updated_at': DateTime.now(),
    };
  }
}
