import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/helper/bottom_navigation_helper.dart';

import '../view/post_view/dashboard_home.dart';
import '../view/sewa_view/booking_screen/booking_screen.dart';
import '../view/sewa_view/home_screen/home_screen.dart';
import '../view/todo_view/add_task.dart';
import '../view/todo_view/home_page.dart';

class AppRoute {
  static final router = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          int currentIndex = _calculateIndex(state.matchedLocation);
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationHelper.buildBottomNavigation(
              currentIndex: currentIndex,
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.go('/dashboard');
                    break;
                  case 1:
                    context.go('/todoHome');
                    break;
                  case 2:
                    context.go('/sewaHome');
                    break;
                }
              },
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardHome(),
          ),
          GoRoute(
            path: '/todoHome',
            builder: (context, state) => const HomePage(),
            routes: [
              GoRoute(
                path: 'addTaskEdit/:id',
                builder: (context, state) {
                  final taskId = state.pathParameters['id'];
                  return AddTaskPage(taskId: taskId);
                },
              ),
              GoRoute(
                path: 'addTask',
                builder: (context, state) {
                  return AddTaskPage();
                },
              ),
            ],
          ),
          GoRoute(
            path: '/sewaHome',
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'booking/:id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return BottomSheetPage(featuredServiceID: id);
                },
              ),
            ],
          )
        ],
      ),
    ],
  );

  static int _calculateIndex(String location) {
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/todoHome')) return 1;
    if (location.startsWith('/sewaHome')) return 2;
    return 0;
  }
}