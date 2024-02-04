import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PatientOverviewModel extends Equatable {
  final String dateCase;
  final List<Image> images;
  final String description;
  final String diagnosis;
  final List<Image> diagnosisImages;
  final String diagnosisCategory;

  const PatientOverviewModel({
    required this.dateCase,
    required this.images,
    required this.description,
    required this.diagnosis,
    required this.diagnosisImages,
    required this.diagnosisCategory,
  });

  @override
  List<Object> get props => [
        dateCase,
        images,
        description,
        diagnosis,
        diagnosisImages,
        diagnosisCategory
      ];

  factory PatientOverviewModel.fromJson(Map<String, dynamic> json) {
    return PatientOverviewModel(
        dateCase: json['start_created_post'],
        images: json['image'],
        description: json['description'],
        diagnosis: json['diagnosis'] ?? '',
        diagnosisImages: json['diagnosis_images'],
        diagnosisCategory: json['diagnosis_category'] ?? '');
  }
}
