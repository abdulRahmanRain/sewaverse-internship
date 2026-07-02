import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/bloc/gray_volf_bloc/gray_volf_bloc.dart';
import 'package:todo_app/bloc/gray_volf_bloc/gray_volf_state.dart';
import 'package:todo_app/config/app_route_path.dart';
import 'package:todo_app/data/repository/gray_volf_repo/job_types_repo.dart';
import 'package:todo_app/domain/models/gray_volf_model/job_type_model.dart';


class JobBaseScreen extends StatefulWidget {
  final Widget child;

  const JobBaseScreen({super.key, required this.child});

  @override
  State<JobBaseScreen> createState() => _JobBaseScreenState();
}

class _JobBaseScreenState extends State<JobBaseScreen> {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int currentIndex = 0;
    if (location.startsWith(AppRoutePath.grayHomeScreen)){
      currentIndex = 0;
    }
    else if (location.startsWith('/jobListScreen')) {currentIndex = 1;}
    else if (location.startsWith(AppRoutePath.profileScreen)) {currentIndex = 3;}
    else if (location.startsWith('/todoHome')){ currentIndex = 4;}


    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: widget.child,
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Container(
              height: 88,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(1, 1),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => context.go(AppRoutePath.grayHomeScreen),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: currentIndex == 0
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: currentIndex == 0
                          ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.home, color: Colors.blue),
                          SizedBox(width: 4),
                          Text("Home", style: TextStyle(color: Colors.blue)),
                        ],
                      )
                          : const Icon(Icons.home, color: Colors.grey),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.work,
                        color: currentIndex == 1 ? Colors.blue : Colors.grey),
                    onPressed: (){}
                  ),
                  IconButton(
                    icon: Icon(Icons.task,
                        color: currentIndex == 4 ? Colors.blue : Colors.grey),
                    onPressed: (){},
                  ),
                  InkWell(
                    onTap: () => context.go(AppRoutePath.profileScreen),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: currentIndex == 3
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: currentIndex == 3
                          ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.person_rounded, color: Colors.black),
                          SizedBox(width: 4),
                          Text("Profile", style: TextStyle(color: Colors.blue)),
                        ],
                      )
                          : const Icon(Icons.person_rounded, color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}
