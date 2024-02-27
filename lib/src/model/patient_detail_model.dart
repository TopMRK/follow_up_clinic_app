import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientDetailModel extends Equatable {
  final String id;
  final dynamic dateCase;
  final List images;
  final String description;
  final dynamic diagnosisResult;

  const PatientDetailModel({
    required this.id,
    required this.dateCase,
    required this.images,
    required this.description,
    required this.diagnosisResult,
  });

  @override
  List<Object> get props => [
        id,
        dateCase,
        images,
        description,
        diagnosisResult,
      ];

  factory PatientDetailModel.fromJson(pid, Map<String, dynamic> json) {
    return PatientDetailModel(
      id: pid,
      dateCase: json['start_created_post'],
      images: json['image'],
      description: json['description'],
      diagnosisResult: json['diagnosis_result'] ?? {},
    );
  }
}
