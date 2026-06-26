import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application_layer/network/dio_crud.dart';
import 'package:todo_app/bloc/gray_volf_bloc/gray_volf_bloc.dart';
import 'package:todo_app/bloc/sewaverse_home/sewaverse_bloc.dart';



import 'package:todo_app/bloc/todo_app/todo_bloc.dart';
import 'package:todo_app/config/app_route.dart';
import 'package:todo_app/cubit/sewaverse_cubit/sewaverse_cubit.dart';
import 'package:todo_app/data/repository/gray_volf_repo/job_types_repo.dart';
import 'package:todo_app/data/repository/sewa_repo/sewaverse_repo.dart';
import 'package:todo_app/data/repository/sewaverse_home_repo/sewaverse_repo.dart';
import 'package:todo_app/view/auth/user_home_screen.dart';
import 'package:todo_app/view/gray_volf/gray_volf_home_screen.dart';
import 'package:todo_app/view/sewaverse_home_card/sewaverse_home_card.dart';
import 'package:todo_app/view/sewaverse_home_card/sewaverse_home_card_cubit.dart';
import 'bloc/post_app/post_bloc.dart';
import 'bloc/post_app/post_event.dart';
import 'bloc/sewa_app/sewa_bloc/sewa_bloc.dart';
import 'bloc/sewa_app/sewa_booking_bloc/booking_bloc.dart';
import 'bloc/user_mode/user_mode_bloc.dart';
import 'bloc/user_mode/user_mode_event.dart';
import 'config/app_route.dart' as AppRoute;
import 'config/di/injection_container.dart';
import 'data/repository/user_mode_repo.dart';



class MyApp extends StatelessWidget {
  MyApp({super.key});

  final SewaverseRepo repo = SewaverseRepo(DioCrud());
  final JobTypesRepo _jobTypesRepo = JobTypesRepo(DioCrud());

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
          child: SewaverseHomeCard(),
        ),
        BlocProvider(
          create: (_) => GrayVolfBloc(_jobTypesRepo),
          child: JobListScreen(),
        ),
        BlocProvider(
          create: (_) => SewaverseCubit(repo),
          child: SewaverseHomeCardCubit(),
        ),

      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoute.router,
        theme: ThemeData(

            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              secondary: Colors.black,

            ),

            textTheme: TextTheme(
              headlineLarge: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                height: 1.0,
                letterSpacing: 0,
                color: Color(0xFF0A66C2),
              ),

              headlineMedium: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                height: 1.2,
                letterSpacing: 0.15,
              ),

              labelMedium: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.4,
                letterSpacing: 0,
                color: Color(0xFF474747),
              ),
            )
        ),
        darkTheme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF121212),

            colorScheme: const ColorScheme.dark(
              primary: Colors.black,
              secondary: Colors.white,

            ),

            iconTheme: const IconThemeData(
              color: Colors.black,
              size: 24,
            ),

            textTheme: TextTheme(

              headlineLarge: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                height: 1.0,
                letterSpacing: 0,
                color: Colors.white,
              ),

              headlineMedium: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  letterSpacing: 0.15,
                  color: Colors.white
              ),

              labelMedium: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.0,
                letterSpacing: 0,
                color: Colors.white,
              ),
            )
        ),

        themeMode: ThemeMode.system,

      ),
    );
  }
}