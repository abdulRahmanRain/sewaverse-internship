
import '../domain/models/UserModel.dart';

class UserState {
  final bool isLoading;
  final List<UserModel> users;
  final String? error;

  const UserState({
    this.isLoading = false,
    this.users = const [],
    this.error,
  });

  UserState copyWith({
    bool? isLoading,
    List<UserModel>? users,
    String? error,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      error: error,
    );
  }
}