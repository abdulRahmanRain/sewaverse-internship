abstract class LoginEvent {}


class UserLoginEvent extends LoginEvent {
  final String userName;
  final String password;

  UserLoginEvent({required this.userName, required this.password});
}
