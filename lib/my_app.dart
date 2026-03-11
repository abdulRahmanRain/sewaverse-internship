import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import 'package:todo_app/bloc/todo_app/todo_bloc.dart';
import 'package:todo_app/config/app_route.dart';
import 'bloc/post_app/post_bloc.dart';
import 'bloc/post_app/post_event.dart';
import 'bloc/sewa_app/sewa_bloc/sewa_bloc.dart';
import 'bloc/sewa_app/sewa_booking_bloc/booking_bloc.dart';
import 'config/di/injection_container.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (_) => getIt<TodoBloc>(),
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

      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoute.router,
      ),
    );
  }
}