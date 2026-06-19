import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/data/repository/user_repo.dart';
import 'package:todo_app/domain/models/UserModel.dart';
import 'package:todo_app/view/animinition_examples.dart';
import 'package:todo_app/view/explicit_example.dart';
import 'package:todo_app/view/sewa_view/home_screen/radar_animination.dart';
import 'package:todo_app/view/sewa_view/home_screen/user_profile_screen.dart';

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
      final data = await loadUsersNormal();
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

  final TextEditingController _searchController = TextEditingController();
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

  void _onSuggestionTap(String search) {
    setState(() {
      _searchController.text = search;
      showSuggestions = false;
      filteredUser = [];
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();

  }
  int selectedIndex = -1;
  bool isBig = false;

  @override
  void initState() {
  super.initState();

    _searchController.addListener(() {
      if (_searchController.text.isEmpty){
        setState(() {
          showSuggestions = false;
        });
  }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfileScreen()),
            );
          },
          child: Hero(
            tag: "myTag",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/img.png",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          labelText: 'Search ',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: _onTextChanged,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        )
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
        child: Column(
          children: [

            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: _searchController.text.isEmpty
                  ? const SizedBox()
                  : filteredUser.isNotEmpty
                  ? SizedBox(
                key: const ValueKey("suggestions"),
                height: 200,
                child: ListView(
                  children: filteredUser.map((user) {
                    return ListTile(
                      title: Text(user.customerName),
                      onTap: () => _onSuggestionTap(user.customerName),
                    );
                  }).toList(),
                ),
              )
                  : null
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RadarAnimation(),
                Spacer(),
                Expanded(child: Text("Total Sale: $sum")),
              ],
            ),

            const SizedBox(height: 10),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final titles = [
                  "Load Users (Normal)",
                  "Load Users (Isolate)",
                  "Clear Users",
                  "Switch Users",
                ];

                return AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  curve: Curves.bounceInOut,
                  transform: Matrix4.identity()
                    ..scale(selectedIndex == index ? 1.2 : 1.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = index;
                      });

                      switch (index) {
                        case 0:
                          fetchUsersNormal();
                          break;
                        case 1:
                          fetchUsersIsolate();
                          break;
                        case 2:
                          clearUsers();
                          break;
                        case 3:
                          setState(() => oddId = !oddId);
                          switchUser();
                          break;
                      }
                    },
                    child: Text(titles[index]),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  isBig = !isBig;
                });
              },
              child: Text(isBig ? 'Make Small' : 'Make Big'),
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


                      return  Column(
                        children: [
                          ListTile(

                            title: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              style: TextStyle(
                                fontSize: isBig ? 28 : 18,
                                color: isBig ? Colors.red : Colors.blue,
                                fontWeight:
                                isBig ? FontWeight.bold : FontWeight.normal,
                              ),
                              child: Text(user.customerName),
                            ),

                            subtitle: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 500),
                              style: TextStyle(
                                fontSize: isBig ? 20 : 14,
                                color: isBig ? Colors.black : Colors.grey,
                              ),
                              child: Text(user.productName),
                            ),

                            trailing: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 500),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                  child: Text("Rs. ${user.totalAmount}"),
                                ),
                                Text("id. $id"),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ExplicitExample()));
      }),
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
