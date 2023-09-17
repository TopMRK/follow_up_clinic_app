import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  void sendResetPassword(email) async {
    emit(ResetPasswordLoading());
    try {
      emit(ResetPasswordLoading());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ResetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(ResetPasswordError('ไม่พบบัญชีผู้ใช้งาน'));
      }
    }
  }
}
