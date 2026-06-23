import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/models/UserModel.dart';
import '../../domain/models/user_model_2.dart';

class UserRepository {

  Future<List<UserModel2>> loadUsersNormal() async {
    final jsonString = await rootBundle.loadString(
      'assets/json/15mb.json',
    );

    final List data = jsonDecode(jsonString);

    return data
        .map((e) => UserModel2.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<UserModel>> loadPremiumUser() async {
    final jsonString = await rootBundle.loadString(
      'assets/json/Amazon_1-level_46-MB_minified.json',
    );

    final List data = jsonDecode(jsonString);

    return data.map((e) => UserModel.fromJson(e)).toList();
  }
}