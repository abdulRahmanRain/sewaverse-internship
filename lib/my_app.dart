import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Post & Todo
import 'package:todo_app/application_layer/api_endpoints.dart';
import 'package:todo_app/bloc/post/post_bloc.dart';
import 'package:todo_app/bloc/post/post_event.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/data/post_repositories.dart';


// Screens
import 'package:todo_app/view/main_page.dart';

// Dio Client
import 'package:todo_app/application_layer/network/dio_client.dart';

import 'application_layer/network/dio_crud.dart';
import 'bloc/sewa_bloc/sewa_bloc.dart';
import 'bloc/sewa_booking_bloc/booking_bloc.dart';
import 'data/repository/sewa_booking_repo.dart';
import 'data/repository/sewaverse_repo.dart';

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
        // Todo Bloc
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // You can decide which screen to show first
        home: const Dashboard(), // Sewaverse home screen
        // home: const Dashboard(), // Uncomment if you want todo/post dashboard as first screen
      ),
    );
  }
}