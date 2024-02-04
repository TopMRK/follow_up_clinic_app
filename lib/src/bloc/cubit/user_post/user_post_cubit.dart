import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:follow_up_clinic_app/src/model/user_post_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'user_post_state.dart';

class UserPostCubit extends Cubit<UserPostState> {
  UserPostCubit() : super(UserPostInitial());

  Future<void> userNewPost(
      String description, List images, DateTime startDate) async {
    final db = FirebaseFirestore.instance;
    // final storage = FirebaseStorage.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final storageRef = FirebaseStorage.instance.ref();
    List<dynamic> imageURL = [];

    final result = await InternetConnectionChecker().hasConnection;

    if (result) {
      try {
        emit(UserPostLoading());

        await Future.wait(images.map((image) async {
          // final imagesRef = storageRef.child(image.name);
          final spaceRef = storageRef
              .child("${auth.currentUser!.uid}/${image['picture'].name}");
          try {
            await spaceRef.putFile(File(image['picture'].path));
          } catch (e) {
            print(e);
          }
          String url = (await spaceRef.getDownloadURL()).toString();
          dynamic value = {'url': url, 'left_eye': image['left_eye']};
          imageURL.add(value);
        }));

        UserPostModel post = UserPostModel(
            uid: auth.currentUser!.uid,
            startCratedPost: startDate,
            description: description,
            imageURL: imageURL);

        db.collection('posts').add(post.toMap()).then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));

        emit(UserPostSuccess());
      } on FirebaseException catch (e) {
        print(e);
        emit(UserPostError());
      }
    } else {
      emit(UserPostError());
    }
  }
}
