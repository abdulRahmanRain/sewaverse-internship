import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_mode/user_mode_bloc.dart';
import '../../bloc/user_mode/user_mode_event.dart';
import '../../bloc/user_mode/user_mode_state.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
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
            heroTag: "refresh",
            onPressed: () {
              context.read<UserModeBloc>().add(RefreshUsers());
            },
            child: const Icon(Icons.refresh),
          ),

          const SizedBox(height: 10),

          FloatingActionButton(
            heroTag: "switch",
            onPressed: () {
              final bloc = context.read<UserModeBloc>();
              final state = bloc.state;

              if (state is! UserLoaded) return;

              final newType =
              state.userType == 'Normal'
                  ? 'Premium'
                  : 'Normal';

              bloc.add(ChangeUserType(newType));
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