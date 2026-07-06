import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignOutRequested extends AuthEvent {
  final String email;
  SignOutRequested(this.email);
}

class AuthCheckRequested extends AuthEvent {}


class SwitchAccountRequested extends AuthEvent {
  final String email;
  SwitchAccountRequested(this.email);
}


class ListAccountsRequested extends AuthEvent {}

class GoogleSignInRequested extends AuthEvent {}
