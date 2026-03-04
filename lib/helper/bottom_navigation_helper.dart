
import 'package:flutter/material.dart';

class BottomNavigationHelper {
  static Widget buildBottomNavigation({
    required int currentIndex,
    required Function(int) onTap,
  }) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items:  [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Todo App',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/sewaLogo.png',height: 40,width: 40,),
          label: "Sewaverse",
        ),
      ],
    );
  }
}