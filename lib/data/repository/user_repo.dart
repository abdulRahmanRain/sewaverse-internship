import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/domain/models/UserModel.dart';

Future<List<UserModel>> loadUsersNormal() async {
  final jsonString = await rootBundle.loadString(
    'assets/json/Amazon_1-level_46-MB_minified.json',
  );

  final List data = jsonDecode(jsonString);

  return data.map((e) => UserModel.fromJson(e)).toList();
}


Future<UserResult> loadUsersIsolate() async {
  final jsonString = await rootBundle.loadString(
    'assets/json/Amazon_1-level_46-MB_minified.json',
  );

  return compute(parseUsers, jsonString);
}



UserResult parseUsers(String jsonString) {
  final List data = jsonDecode(jsonString);

  final users = data.map((e) => UserModel.fromJson(e)).toList();

  final totalSum = users.fold(
    0.0,
        (sum, user) => sum + user.totalAmount,
  );

  return UserResult(
    allUsers: users,
    totalSum: totalSum,
  );
}

class UserResult {
  final List<UserModel> allUsers;
  final double totalSum;

  UserResult({
    required this.allUsers,
    required this.totalSum,
  });
}


