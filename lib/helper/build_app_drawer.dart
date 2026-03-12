import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/helper/sewa_helper/custom_cricle_avtar.dart';
import '../storage/local_storage/hive_storage.dart';

Drawer buildAppDrawer({
  required BuildContext context,
  required HiveStorage hiveStorage,
  required VoidCallback onLogOut
}) {
  String userName = hiveStorage.getUserName();

  return Drawer(
    child: Column(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(userName),
          accountEmail: Text("example@email.com"),
          currentAccountPicture: CustomCircleAvtar.providerAvatar(providerName: userName, providerImage: ""),
          decoration: const BoxDecoration(color: Colors.blue),
        ),


        const Divider(),

        // Logout
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("Logout"),
          onTap: (){
            onLogOut();
            context.go('/loginPage');
          },
        ),
      ],
    ),
  );
}