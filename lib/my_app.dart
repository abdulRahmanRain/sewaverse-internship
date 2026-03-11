import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/application_layer/api_endpoints.dart';

import 'package:todo_app/bloc/todo_app/todo_bloc.dart';
import 'package:todo_app/config/app_route.dart';
import 'package:todo_app/data/repository/post_repo/post_repositories.dart';



import 'package:todo_app/application_layer/network/dio_client.dart';

import 'application_layer/network/dio_crud.dart';
import 'bloc/post_app/post_bloc.dart';
import 'bloc/post_app/post_event.dart';
import 'bloc/sewa_app/sewa_bloc/sewa_bloc.dart';
import 'bloc/sewa_app/sewa_booking_bloc/booking_bloc.dart';
import 'data/repository/sewa_repo/sewa_booking_repo.dart';
import 'data/repository/sewa_repo/sewaverse_repo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Post repositories
    final postRepositories = PostRepositories(
      DioClient(baseUrl: ApiEndpoints.baseUrl),
    );

    // Sewaverse repositories
    final dioCrud = DioCrud();
    final sewaRepository = SewaverseRepository(dioCrud: dioCrud);
    final sewaBookingRepository = BookingRepository(dioCrud: dioCrud);

    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(),
        ),

        // Post Bloc
        BlocProvider<PostBloc>(
          create: (context) => PostBloc(postRepositories)..add(FetchPostsEvent()),
        ),

        // Sewa Bloc
        BlocProvider<SewaBloc>(
          create: (context) => SewaBloc(repository: sewaRepository),
        ),

        // Booking Bloc
        BlocProvider<BookingBloc>(
          create: (context) => BookingBloc(bookingRepository: sewaBookingRepository),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoute.router,
      )
    );
  }
}