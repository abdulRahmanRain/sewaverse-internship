import 'package:flutter/material.dart';
import 'package:todo_app/view/full_auth_screen/splash_screen.dart';
import 'package:todo_app/view/sewaverse_home_card/sewaverse_home_card_cubit.dart';
import 'package:todo_app/view/sewaverse_home_card/sewaverse_home_card.dart';
import 'package:todo_app/view/sewaverse_featured_card/featured_sewa_home_screen.dart';
import 'package:todo_app/view/Isolated_home_page/user_screen.dart';
import 'package:todo_app/view/todo_view/todo_home_page.dart';

import 'dashboard/post_dashboard_home.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;

  final pages = [
    const DashboardHome(),
    const SewaverseHomeCard(),
    const UserScreen(),
    // const FeaturedSewaHomeScreen(),
    // const TodoHomePage(),
    const SplashScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'sewaverse ',
          ),
          NavigationDestination(
            icon: Icon(Icons.task),
            label: 'Isolated',
          ),
          // NavigationDestination(
          //   icon: Icon(Icons.miscellaneous_services),
          //   label: 'Featured Sewa',
          // ),
          // NavigationDestination(
          //   icon: Icon(Icons.flutter_dash),
          //   label: 'Todo app',
          // ),
          NavigationDestination(
            icon: Icon(Icons.flutter_dash),
            label: 'Splash',
          ),
        ],
      ),
    );
  }
}