import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String email;
  final String password;

  const Login(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
