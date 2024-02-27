import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:follow_up_clinic_app/src/model/patient_detail_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'patient_detail_state.dart';

class PatientDetailCubit extends Cubit<PatientDetailState> {
  PatientDetailCubit() : super(PatientDetailInitial());

  Future<void> getPatientHistory(uid) async {
    final db = FirebaseFirestore.instance;
    final result = await InternetConnectionChecker().hasConnection;

    emit(PatientDetailLoading());

    if (result) {
      try {
        db.collection('posts').where('uid', isEqualTo: uid).get().then((value) {
          List dataList = value.docs
              .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => doc)
              .toList();
          List<PatientDetailModel> data = dataList
              .map((json) => PatientDetailModel.fromJson(json.id, json.data()))
              .toList();
          print(data);
          emit(PatientDetailSuccess(data));
        });
      } on FirebaseException catch (e) {
        print(e);
      }
    } else {
      emit(const PatientDetailError('ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้'));
    }
  }
}
