part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationFail extends AuthenticationState {}

final class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess(this.data, this.role);

  final String data;
  final String role;
}
