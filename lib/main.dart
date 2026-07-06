import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/my_app.dart';

import 'config/di/injection_container.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await GoogleSignIn.instance.initialize(
      clientId : "831387944311-a96m2jdoqjeao5lp9bdvmd9g94dejhj4.apps.googleusercontent.com"
  );

  await Hive.initFlutter();
  await Hive.openBox('myBox');
  await Hive.openBox('authBox');
  await Hive.openBox('dataBox');
  setupDependencies();
  runApp(MyApp());
}