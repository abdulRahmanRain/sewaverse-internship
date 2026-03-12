import 'package:todo_app/storage/local_storage/hive_storage.dart';

class Auth {
  static bool isAuthenticatedUser = HiveStorage.isUserLoggedIn();
  static Future<void> isUserLogOut = HiveStorage.logout();

}