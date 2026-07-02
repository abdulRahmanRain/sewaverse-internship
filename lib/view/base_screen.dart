import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/config/app_route_path.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  const BaseScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int currentIndex = 0;
    if (location.startsWith('/dashboard')){
      currentIndex = 0;
    }
    else if (location.startsWith(AppRoutePath.grayHomeScreen)) {currentIndex = 1;}
    else if (location.startsWith('/sewaHome')) {currentIndex = 3;}
    else if (location.startsWith('/todoHome')){ currentIndex = 4;}

    return Scaffold(
      body: child,


      floatingActionButton: FloatingActionButton(
        onPressed: () {

          context.go('/addTask');
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabItem(context, Icons.location_on,
                "Home",
                0,
                '/dashboard',
                null,
                currentIndex
            ),
            _buildTabItem(
                context,
                Icons.work,
                "Jobs",
                1,
                AppRoutePath.grayHomeScreen,
                (){
                  context.push(AppRoutePath.grayHomeScreen);
                },
                currentIndex
            ),
            _buildTabItem(
                context,
                Icons.add_circle_outline,
                "Featured Sewa",
                3,
                '/sewaHome',
                null,
                currentIndex),
            _buildTabItem(
                context,
                Icons.notifications,
                "Tasks",
                4,
                '/todoHome',
                null,
                currentIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(BuildContext context,
      IconData icon,
      String label,
      int index,
      String route,
      VoidCallback? onTap,
      int currentIndex) {
    final isSelected = currentIndex == index;
    return InkWell(
      onTap: onTap ?? () => context.go(route),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.purple : Colors.grey),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.purple : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
