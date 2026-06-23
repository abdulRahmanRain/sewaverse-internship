import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../bloc/user_mode/user_mode_bloc.dart';
import '../../bloc/user_mode/user_mode_event.dart';
import 'login_screen.dart';

class SwitchAccountScreen extends StatefulWidget {
  const SwitchAccountScreen({super.key});

  @override
  State<SwitchAccountScreen> createState() => _SwitchAccountScreenState();
}

class _SwitchAccountScreenState extends State<SwitchAccountScreen> {
  final _authBox = Hive.box('authBox');

  @override
  Widget build(BuildContext context) {
    final List users = _authBox.get('users', defaultValue: []);
    final currentUser = _authBox.get('currentUser');

    return Scaffold(
      appBar: AppBar(title: const Text("Switch Account")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                final isActive =
                    currentUser != null &&
                        currentUser['username'] == user['username'];

                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(user['username'] ?? 'No Username'),
                  subtitle: Text(user['userType'] ?? 'normal'),
                  trailing: isActive
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () {
                    _authBox.put('currentUser', user);
                    _authBox.put('userType', user['userType'] ?? 'Normal');

                    context.read<UserModeBloc>().add(
                      ChangeUserType(
                        userType: user['userType'] ?? 'Normal',
                      ),
                    );

                    context.read<UserModeBloc>().add(FetchUsers());

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Switched to ${user['username']}'),
                      ),
                    );

                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
              );
            },
            leading: const CircleAvatar(child: Icon(Icons.person_add)),
            title: const Text('Add Account'),
          ),
          const SizedBox(height: 30,),
          ListTile(
            onTap: () {
              _authBox.put('currentUser', null);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
              );
            },
            leading: const CircleAvatar(child: Icon(Icons.logout)),
            title: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}