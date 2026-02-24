import 'package:flutter/material.dart';


class WidgetHelper {

  static Widget buildBottomNavBar({
    required int currentIndex,
    required Function(int) onTap,
  }) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "DashBoard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note_alt),
          label: "API",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Todo App",
        ),
      ],
    );
  }
}