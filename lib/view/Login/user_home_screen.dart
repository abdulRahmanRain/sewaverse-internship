import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/view/Login/switch_account.dart';

import '../../bloc/user_mode/user_mode_bloc.dart';
import '../../bloc/user_mode/user_mode_event.dart';
import '../../bloc/user_mode/user_mode_state.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {

  final _authBox = Hive.box('authBox');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          FloatingActionButton(
            heroTag: "fetch",
            onPressed: () {
              context.read<UserModeBloc>().add(FetchUsers());
            },
            child: const Icon(Icons.download),
          ),


          const SizedBox(height: 10),

          FloatingActionButton(
            heroTag: "switch",


            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SwitchAccountScreen(),
                ),
              );
            },
            child: const Icon(Icons.swap_horiz),
          ),
        ],
      ),

      body: BlocBuilder<UserModeBloc, UserModeState>(
        builder: (context, state) {

          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final item = state.users[index];

                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.email),
                  trailing: Text(item.phone),
                );
              },
            );
          }

          if (state is PremiumUserLoaded) {
            return ListView.builder(
              itemCount: state.premiumUsers.length,
              itemBuilder: (context, index) {
                final item = state.premiumUsers[index];

                return ListTile(
                  title: Text(item.customerName),
                  subtitle: Text(item.productName),
                  trailing: Text(item.category),
                );
              },
            );
          }

          if (state is UserError) {
            return Center(child: Text(state.message));
          }

          return const Center(
            child: Text("Press Fetch to load data"),
          );
        },
      ),
    );
  }
}