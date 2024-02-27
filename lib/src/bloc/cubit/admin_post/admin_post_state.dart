part of 'admin_post_cubit.dart';

sealed class AdminPostState extends Equatable {
  const AdminPostState();

  @override
  List<Object> get props => [];
}

final class AdminPostInitial extends AdminPostState {}

final class AdminPostLoading extends AdminPostState {}

final class AdminPostError extends AdminPostState {}

final class AdminPostSuccess extends AdminPostState {}
