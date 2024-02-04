import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
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
        db.collection('post').where('uid', isEqualTo: uid).get().then((value) {
          // List data = value.docs.map((e) => null)
        });
      } on FirebaseException catch (e) {
        print(e);
      }

      emit(PatientDetailSuccess());
    } else {
      emit(const PatientDetailError('ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้'));
    }
  }
}
