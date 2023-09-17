part of 'reset_password_cubit.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordLoading extends ResetPasswordState {}

final class ResetPasswordSuccess extends ResetPasswordState {}

final class ResetPasswordError extends ResetPasswordState {
  const ResetPasswordError(this.message);

  final String message;
}
