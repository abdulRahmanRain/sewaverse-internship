import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../storage/local_storage/hive_storage.dart';

Drawer buildAppDrawer({
  required BuildContext context,
  required HiveStorage hiveStorage,
}) {
  String userName = hiveStorage.getUserName();

  return Drawer(
    child: Column(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(userName.isNotEmpty ? userName : "User"),
          accountEmail: Text("example@email.com"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              userName.isNotEmpty ? userName[0] : "U",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          decoration: const BoxDecoration(color: Colors.blue),
        ),


        const Divider(),

        // Logout
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("Logout"),
          onTap: () async {
            await hiveStorage.logout();
            context.go('/loginPage');
          },
        ),
      ],
    ),
  );
}