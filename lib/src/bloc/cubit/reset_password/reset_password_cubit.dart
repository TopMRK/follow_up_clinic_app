import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  void sendResetPassword(email) async {
    final result = await InternetConnectionChecker().hasConnection;

    if (result) {
      try {
        emit(ResetPasswordLoading());
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        emit(ResetPasswordSuccess());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(ResetPasswordError('ไม่พบบัญชีผู้ใช้งาน'));
        }
      }
    } else {
      emit(ResetPasswordError('ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้'));
    }
  }
}
