import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../model/register_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void registerUser(Register user) async {
    bool result = await InternetConnectionChecker().hasConnection;

    if (result) {
      try {
        emit(RegisterLoading());
        final db = FirebaseFirestore.instance;
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: user.email,
              password: user.password,
            )
            .then((value) => db
                .collection('users')
                .doc(value.user?.uid)
                .set(user.toMap())
                .onError((error, stackTrace) => print(error)));
        emit(RegisterSuccess());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(const RegisterError('รหัสผ่านคาดเดาง่ายเกินไป'));
        } else if (e.code == 'email-already-in-use') {
          emit(const RegisterError('อีเมลนี้มีการลงทะเบียนเรียบร้อยแล้ว'));
        }
      } catch (e) {
        print(e);
      }
    } else {
      emit(const RegisterError('ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้'));
    }
  }
}
