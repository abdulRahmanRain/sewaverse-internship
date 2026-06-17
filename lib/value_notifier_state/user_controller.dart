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

  List<UserModel> allUser(List<UserModel> users) {
    state.value = state.value.copyWith(
      isLoading: false,
      users: users,
      error: null,
    );
    return state.value.users;
  }

  void evenCustomerId(List<UserModel> users) {
    final allEvenUsers = users.where((user) {
      final idNumber = int.parse(
        user.customerId.replaceAll(RegExp(r'[^0-9]'), ''),
      );

      return idNumber % 2 == 0;
    }).toList();

    state.value = state.value.copyWith(
      isLoading: false,
      users: allEvenUsers,
      error: null,
    );
  }

  void oddUserId(List<UserModel> users) {
    final allOddUsers = users.where((user) {
      final idNumber = int.parse(
        user.customerId.replaceAll(RegExp(r'[^0-9]'), ''),
      );

      return idNumber % 2 != 0;
    }).toList();

    state.value = state.value.copyWith(
      isLoading: false,
      users: allOddUsers,
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
