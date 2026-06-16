import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/view/sewa_view/home_screen/user_screen.dart';

import '../view/post_view/dashboard_home.dart';
import '../view/sewa/home.dart';
import '../view/sewa/cubit.dart';
import '../view/sewa_view/home_screen/home_screen.dart';
import '../view/todo_view/home_page.dart';
import '../view/todo_view/add_task.dart';
import '../view/sewa_view/booking_screen/booking_screen.dart';
import 'package:todo_app/helper/bottom_navigation_helper.dart';

class AppRoute {
  static final router = GoRouter(
    initialLocation: '/dashboard',
    routes: [

      ShellRoute(
        builder: (context, state, child) {
          final index = _calculateIndex(state.uri.toString());

          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationHelper.buildBottomNavigation(
              currentIndex: index,
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.go('/dashboard');
                    break;
                  case 1:
                    context.go('/sewaverseHome');
                    break;
                  case 2:
                    context.go('/todoHome');
                    break;
                  case 3:
                    context.go('/sewaHome');
                    break;
                  case 4:
                    context.go('/sewaverseHomeCubit');
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
            path: '/sewaverseHome',
            builder: (context, state) => const Home(),
          ),

          GoRoute(
            path: '/sewaverseHomeCubit',
            builder: (context, state) => const CubitHome(),
          ),

          GoRoute(
            path: '/todoHome',
            builder: (context, state) => const UserScreen(),
            routes: [
              GoRoute(
                path: 'addTask',
                builder: (context, state) => AddTaskPage(),
              ),
              GoRoute(
                path: 'addTaskEdit/:id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return AddTaskPage(taskId: id);
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
          ),
        ],
      ),
    ],
  );

  static int _calculateIndex(String location) {
    if (location == '/dashboard') return 0;
    if (location == '/sewaverseHome') return 1;
    if (location.startsWith('/todoHome')) return 2;
    if (location.startsWith('/sewaHome')) return 3;
    if (location == '/sewaverseHomeCubit') return 4;

    return 0;
  }
}