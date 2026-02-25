import 'package:flutter/material.dart';
import 'package:todo_app/helper/bottom_navigation_helper.dart';
import 'package:todo_app/view/dashboard_home.dart';
import 'home_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex =0;
  final List<Widget> screens = const [
    DashboardHome(),
    HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens
      ),
      bottomNavigationBar: BottomNavigationHelper.buildBottomNavigation(
          currentIndex: currentIndex,
          onTap: (index){
            setState(() {
              currentIndex = index;
            });
          }
      ),
    );
  }
}
