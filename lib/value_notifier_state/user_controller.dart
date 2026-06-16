import 'package:flutter/material.dart';
import '../domain/models/UserModel.dart';
import 'user_state.dart';

class UserController {
  final ValueNotifier<UserState> state =
  ValueNotifier(const UserState(isLoading: false));

  void setLoading() {
    state.value = state.value.copyWith(
      isLoading: true,
      error: null,
    );
  }

  void setUsers(List<UserModel> users) {
    state.value = state.value.copyWith(
      isLoading: false,
      users: users,
      error: null,
    );
  }


  void setError(String message) {
    state.value = state.value.copyWith(
      isLoading: false,
      error: message,
    );
  }

  void clear() {
    state.value = const UserState();
  }
}