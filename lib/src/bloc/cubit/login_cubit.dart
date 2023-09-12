import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial(''));

  void firebaseLogin(emailAddress, password) async {
    emit(LoginLoading('กำลังดาวน์โหลด'));
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      emit(LoginSuccess('Login Completed'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginError('ไม่พบอีเมลผู้ใช้งาน'));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        emit(LoginError('รหัสผ่านไม่ถูกต้อง'));
        print('Wrong password provided for that user.');
      }
    }
  }
}
