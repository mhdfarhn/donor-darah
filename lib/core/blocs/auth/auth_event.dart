part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthStatus extends AuthEvent {}

class SignUpRequest extends AuthEvent {
  final String email;
  final String password;
  final UserModel user;

  const SignUpRequest({
    required this.email,
    required this.password,
    required this.user,
  });

  @override
  List<Object> get props => [email, password, user];
}

class SignInRequest extends AuthEvent {
  final String email;
  final String password;

  const SignInRequest(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignOut extends AuthEvent {
  final String email;

  const SignOut(this.email);

  @override
  List<Object> get props => [email];
}
