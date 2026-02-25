
import 'package:flutter/material.dart';

class BottomNavigationHelper {
  static Widget buildBottomNavigation({
    required int currentIndex,
    required Function(int) onTap,
  }) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Todo App',
        ),
      ],
    );
  }
}