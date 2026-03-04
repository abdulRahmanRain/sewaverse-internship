import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application_layer/api_endpoints.dart';
import 'package:todo_app/application_layer/api_service.dart';
import 'package:todo_app/application_layer/sewa_api_service.dart';
import 'package:todo_app/bloc/post/post_event.dart';
import 'package:todo_app/bloc/sewa/sewa_bloc.dart';
import 'package:todo_app/bloc/sewa/sewa_event.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/data/post_repositories.dart';
import 'package:todo_app/data/sewa_repositories.dart';
import 'package:todo_app/view/main_page.dart';

import 'bloc/post/post_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final  postRepositories = PostRepositories(DioClient(baseUrl: ApiEndpoints.baseUrl));
  final sewaRepositories = SewaRepositories(SewaDioClient(baseUrl: ApiEndPointsSewaverse.baseUrl));

  @override
  Widget build(BuildContext context) {

    return  MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(),
        ),
        BlocProvider<PostBloc>(

          create: (context) => PostBloc(postRepositories)..add(FetchPostsEvent()),
        ),

        BlocProvider<SewaBloc>(
          create: (context)=>SewaBloc(repository: sewaRepositories)..add(FetchSewaEvent()),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Dashboard(),
      ),
    );
  }
}