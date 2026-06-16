import 'package:flutter/material.dart';

class BottomNavigationHelper {
  static Widget buildBottomNavigation({
    required int currentIndex,
    required Function(int) onTap,
  }) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,


      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 10,

      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,

      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),

      unselectedLabelStyle: const TextStyle(
        fontSize: 11,
      ),

      showUnselectedLabels: true,

      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.business_outlined),
          activeIcon: Icon(Icons.business),
          label: 'Sewaverse Home',
        ),


        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Todo App',
        ),

        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/sewaLogo.png',
            height: 24,
            width: 24,
          ),
          activeIcon: Image.asset(
            'assets/sewaLogo.png',
            height: 28,
            width: 28,
          ),
          label: "Sewaverse",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business_outlined),
          activeIcon: Icon(Icons.business),
          label: 'Cubit',
        ),
      ],
    );
  }
}