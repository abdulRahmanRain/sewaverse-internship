import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/my_app.dart';
import 'config/app_config.dart';
import 'helper/fcm_helper.dart';





void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  // Initialize FCM
  await FCMHelper.initFCM(topic: "news");
  String? token = await FirebaseMessaging.instance.getToken();
  print("MAIN TOKEN: $token");
  await Hive.openBox('myBox');
  await Hive.openBox('userBox');
  setupDependencies();
  runApp(MyApp());
}