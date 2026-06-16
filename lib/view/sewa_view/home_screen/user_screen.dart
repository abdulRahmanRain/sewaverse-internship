import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/data/repository/user_repo.dart';
import 'package:todo_app/domain/models/UserModel.dart';
import 'package:todo_app/view/sewa_view/home_screen/radar_animination.dart';

import '../../../value_notifier_state/user_controller.dart';
import '../../../value_notifier_state/user_state.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final controller = UserController();
  final sumNotifier = ValueNotifier<double>(0);
  double sum = 0;

  Future<void> fetchUsersNormal() async {
    controller.setLoading();

    try{
      var data = await loadUsersNormal();
      controller.setUsers(data);
      updateUI(data);
    } catch (e){
      controller.setError(e.toString());
    }
  }

  Future<void> fetchUsersIsolate() async {
    controller.setLoading();

    try {
      final data = await loadUsersIsolate();
      sumNotifier.value = data.totalSum;
      controller.setUsers(data.allUsers);
    } catch (e) {
      controller.setError(e.toString());
    }
  }

  void clearUsers() {
    controller.clear();

    setState(() {
      sum = 0;
    });

    sumNotifier.value = 0;
  }

  void updateUI(List<UserModel> data) {
    final totalSum = data.fold(
      0.0,
          (sum, user) => sum + user.totalAmount,
    );

    setState(() {
      sum = totalSum;
    });

    controller.setUsers(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Sale: $sum"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const RadarAnimation(),

          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => fetchUsersNormal(),
            child: Text("Load Users (Normal)"),
          ),

          ElevatedButton(
            onPressed: () => fetchUsersIsolate(),
            child: Text("Load Users (Isolate)"),
          ),

          ElevatedButton(
            onPressed: () => clearUsers(),
            child: Text("Clear Users"),
          ),

          Expanded(
            child: ValueListenableBuilder<UserState>(
              valueListenable: controller.state,
              builder: (context,state , _) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.error != null) {
                  return Center(
                    child: Text(state.error!),
                  );
                }

                if (state.users.isEmpty) {
                  return const Center(
                    child: Text("No Data"),
                  );
                }

                return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];

                    return ListTile(
                      title: Text(user.customerName),
                      subtitle: Text(user.productName),
                      trailing: Text("Rs. ${user.totalAmount}"),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
