import 'package:equatable/equatable.dart';

class PatientOverviewModel extends Equatable {
  final String userId;
  final String firstname;
  final String lastname;
  final String hn;

  const PatientOverviewModel({
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.hn,
  });

  @override
  List<Object> get props => [userId, firstname, lastname, hn];

  factory PatientOverviewModel.fromJson(Map<String, dynamic> json) {
    return PatientOverviewModel(
        userId: json['address'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        hn: json['hn']);
  }
}
