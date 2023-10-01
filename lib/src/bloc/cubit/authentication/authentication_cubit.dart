import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  void authenticationLogin() async {
    bool authStatus = false;
    String uid = '';
    emit(AuthenticationLoading());
    // ignore: await_only_futures
    await FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        authStatus = false;
      } else {
        uid = user.uid;
        print(uid);
        authStatus = true;
      }
    });

    if (authStatus == true) {
      final db = FirebaseFirestore.instance;
      final docRef = db.collection('users').doc(uid);
      Map<String, dynamic> data;
      docRef.get().then(
        (DocumentSnapshot doc) {
          data = doc.data() as Map<String, dynamic>;
          emit(AuthenticationSuccess(data['firstname'], data['role']));
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } else if (authStatus == false) {
      emit(AuthenticationFail());
    }
  }

  void authenticationLogout() async {
    emit(AuthenticationLoading());
    await FirebaseAuth.instance.signOut();
    emit(AuthenticationFail());
  }
}
