import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:follow_up_clinic_app/src/model/admin_post_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'admin_post_state.dart';

class AdminPostCubit extends Cubit<AdminPostState> {
  AdminPostCubit() : super(AdminPostInitial());

  Future<void> adminNewPost(
      String description, List images, DateTime startDate, String id) async {
    final db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final storageRef = FirebaseStorage.instance.ref();
    List<dynamic> imageURL = [];

    final result = await InternetConnectionChecker().hasConnection;

    if (result) {
      try {
        emit(AdminPostLoading());

        await Future.wait(images.map((image) async {
          final spaceRef = storageRef
              .child("${auth.currentUser!.uid}/${image['picture'].name}");
          try {
            await spaceRef.putFile(File(image['picture'].path));
          } catch (e) {
            print(e);
          }
          String url = (await spaceRef.getDownloadURL()).toString();
          dynamic value = {'url': url};
          imageURL.add(value);
        }));

        AdminPostModel post = AdminPostModel(
            uid: auth.currentUser!.uid,
            startCratedPost: startDate,
            description: description,
            imageURL: imageURL);

        db.collection('posts').doc(id).update(post.toMap());

        emit(AdminPostSuccess());
      } on FirebaseException catch (e) {
        print(e);
        emit(AdminPostError());
      }
    } else {
      emit(AdminPostError());
    }
  }
}
