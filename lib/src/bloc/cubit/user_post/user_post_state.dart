part of 'user_post_cubit.dart';

sealed class UserPostState extends Equatable {
  const UserPostState();

  @override
  List<Object> get props => [];
}

final class UserPostInitial extends UserPostState {}

final class UserPostLoading extends UserPostState {}

final class UserPostSuccess extends UserPostState {}

final class UserPostError extends UserPostState {}
