import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(HomepageInitial());

  void getMedicalHistory() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;

    emit(HomepageLoading());

    db
        .collection('posts')
        .where('uid', isEqualTo: auth.currentUser!.uid)
        .orderBy('created_at', descending: true)
        .get()
        .then(
      (querySnapshot) {
        emit(HomepageSuccess(querySnapshot.docs));
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()["uid"]}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}
