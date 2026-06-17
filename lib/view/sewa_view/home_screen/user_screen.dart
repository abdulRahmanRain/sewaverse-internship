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
  UserResult? latestData;
  bool oddId = false;
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
      switchUser(data: data);
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

  void switchUser({UserResult? data}) {
    if (data != null) {
      latestData = data;
    }

    final users = latestData?.allUsers ?? [];

    if (oddId) {
      controller.oddUserId(users);
    } else {
      controller.evenCustomerId(users);
    }
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

  final TextEditingController _controller = TextEditingController();
  List<UserModel> filteredUser = [];
  bool showSuggestions = false;

  Future<void> _onTextChanged(
      String input,
      ) async {
    if (input.isEmpty) {
      setState(() {
        filteredUser = [];
        showSuggestions = false;
      });
      return;
    }

    final users = controller.state.value.users;

    final results = await compute(
      searchUsers,
      SearchInput(
        users: users,
        input: input,
      ),
    );

    setState(() {
      filteredUser = results;
      showSuggestions = true;
    });
  }

  void _onSuggestionTap(String fruit) {
    setState(() {
      _controller.text = fruit;
      showSuggestions = false;
      filteredUser = [];
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

          ElevatedButton(
            onPressed: (){
              setState(() {
                oddId = !oddId;

              });
              switchUser();
            },
            child: Text("Switch users"),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Search fruit',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: _onTextChanged,
                    ),
              
                    if (showSuggestions)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: filteredUser.isEmpty
                            ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('No match found'),
                        )
                            : Column(
                          children: filteredUser.map((fruit) {
                            return ListTile(
                              title: Text(fruit.customerName),
                              onTap: () => _onSuggestionTap(fruit.customerName),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
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
                    final id = int.parse(user.customerId.replaceAll(RegExp(r'[^0-9]'), ''))%2;


                    return ListTile(
                      title: Text(user.customerName),
                      subtitle: Text(user.productName),
                      trailing: Column(
                        children: [
                          Text("Rs. ${user.totalAmount}"),
                          Text("id. ${id}"),
                        ],
                      ),
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


List<UserModel> searchUsers(
    SearchInput input,
    ) {
  return input.users
      .where(
        (user) => user.customerName
        .toLowerCase()
        .contains(
              input.input.toLowerCase(),
    ),
  ).take(10).toList();
}

class SearchInput {
  final List<UserModel> users;
  final String input;

  SearchInput({
    required this.users,
    required this.input,
  });
}
