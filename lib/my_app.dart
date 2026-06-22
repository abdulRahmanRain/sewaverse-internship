import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application_layer/network/dio_crud.dart';
import 'package:todo_app/bloc/sewaverse_home/sewaverse_bloc.dart';



import 'package:todo_app/bloc/todo_app/todo_bloc.dart';
import 'package:todo_app/config/app_route.dart';
import 'package:todo_app/cubit/sewaverse_cubit/sewaverse_cubit.dart';
import 'package:todo_app/data/repository/sewa_repo/sewaverse_repo.dart';
import 'package:todo_app/data/repository/sewaverse_home_repo/sewaverse_repo.dart';
import 'package:todo_app/view/Login/user_home_screen.dart';
import 'package:todo_app/view/sewa/cubit.dart';
import 'package:todo_app/view/sewa/home.dart';
import 'bloc/post_app/post_bloc.dart';
import 'bloc/post_app/post_event.dart';
import 'bloc/sewa_app/sewa_bloc/sewa_bloc.dart';
import 'bloc/sewa_app/sewa_booking_bloc/booking_bloc.dart';
import 'bloc/user_mode/user_mode_bloc.dart';
import 'bloc/user_mode/user_mode_event.dart';
import 'config/di/injection_container.dart';
import 'data/repository/user_mode_repo.dart';



class MyApp extends StatelessWidget {
  MyApp({super.key});

  final SewaverseRepo repo = SewaverseRepo(DioCrud());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (_) => getIt<TodoBloc>(),
        ),

        BlocProvider(
          create: (_) => UserModeBloc(
            repository: UserRepository(),
          ),
          child: const UserHomeScreen(),
        ),


        BlocProvider(
          create: (_) => getIt<PostBloc>()..add(FetchPostsEvent()),
        ),

        BlocProvider(
          create: (_) => getIt<SewaBloc>(),
        ),

        BlocProvider(
          create: (_) => getIt<BookingBloc>(),
        ),
        BlocProvider(
          create: (_) => SewaverseBloc(repo),
          child: Home(),
        ),


        BlocProvider(
          create: (_) => SewaverseCubit(repo),
          child: CubitHome(),
        ),

      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoute.router,
      ),
    );
  }
}