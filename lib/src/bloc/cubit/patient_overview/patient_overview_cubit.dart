import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:follow_up_clinic_app/src/model/patient_overview_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'patient_overview_state.dart';

class PatientOverviewCubit extends Cubit<PatientOverviewState> {
  PatientOverviewCubit() : super(PatientOverviewInitial());

  Future<void> getPatientAll() async {
    final db = FirebaseFirestore.instance;
    final result = await InternetConnectionChecker().hasConnection;

    // Start loading data from Patient lists.
    if (result) {
      try {
        emit(PatientOverviewLoading());
        db
            .collection('users')
            .where('role', isEqualTo: 'user')
            .get()
            .then((value) {
          // Transform QueryDocumentSnapshot to Map<String, dynamic>
          List<Map<String, dynamic>> dataList = value.docs
              .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
                  doc.data() as Map<String, dynamic>)
              .toList();
          // Add dataList to a model.
          List<PatientOverviewModel> data = dataList
              .map((Map<String, dynamic> json) =>
                  PatientOverviewModel.fromJson(json))
              .toList();
          emit(PatientOverviewSuccess(data));
        });
      } on FirebaseException catch (e) {
        emit(PatientOverviewError(e.toString()));
      }
    } else {
      emit(const PatientOverviewError(
          'ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้ กรุณาลองใหม่อีกครั้ง'));
    }
  }
}
