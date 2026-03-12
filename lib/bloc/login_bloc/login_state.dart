abstract class LoginState {}
class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {

  LoginSuccess();
}
class LoginFailure extends LoginState {
  final String message;
  LoginFailure({required this.message});
}