part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState(this.status);

  final String status;

  @override
  List<Object> get props => [status];
}

final class LoginInitial extends LoginState {
  const LoginInitial(status) : super(status);
}

final class LoginLoading extends LoginState {
  LoginLoading(status) : super(status);
}

final class LoginSuccess extends LoginState {
  LoginSuccess(status) : super(status);
}

final class LoginError extends LoginState {
  LoginError(status) : super(status);
}
