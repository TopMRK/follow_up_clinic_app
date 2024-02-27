import 'package:equatable/equatable.dart';

class AdminPostModel extends Equatable {
  final String uid;
  final DateTime startCratedPost;
  final String description;
  final List imageURL;

  const AdminPostModel({
    required this.uid,
    required this.startCratedPost,
    required this.description,
    required this.imageURL,
  });

  @override
  List<Object> get props => [];

  Map<String, dynamic> toMap() {
    return {
      'diagnosis_result': {
        'uid': uid,
        'start_created_post': startCratedPost,
        'description': description,
        'image': imageURL,
        'created_at': DateTime.now(),
        'updated_at': DateTime.now(),
      }
    };
  }
}
