import 'package:get_it/get_it.dart';
import 'package:todo_app/application_layer/api_endpoints.dart';
import 'package:todo_app/application_layer/network/dio_client.dart';
import 'package:todo_app/application_layer/network/dio_crud.dart';

import 'package:todo_app/bloc/post_app/post_bloc.dart';
import 'package:todo_app/bloc/sewa_app/sewa_bloc/sewa_bloc.dart';
import 'package:todo_app/bloc/sewa_app/sewa_booking_bloc/booking_bloc.dart';
import 'package:todo_app/bloc/todo_app/todo_bloc.dart';

import 'package:todo_app/data/repository/post_repo/post_repositories.dart';
import 'package:todo_app/data/repository/sewa_repo/sewaverse_repo.dart';
import 'package:todo_app/data/repository/sewa_repo/sewa_booking_repo.dart';

final getIt = GetIt.instance;

void setupDependencies() {

  /// Network

  getIt.registerLazySingleton(
        () => DioClient(baseUrl: ApiEndpoints.baseUrl),
  );

  getIt.registerLazySingleton(
        () => DioCrud(),
  );

  /// Repositories

  getIt.registerLazySingleton(
        () => PostRepositories(getIt<DioClient>()),
  );

  getIt.registerLazySingleton(
        () => SewaverseRepository(dioCrud: getIt<DioCrud>()),
  );

  getIt.registerLazySingleton(
        () => BookingRepository(dioCrud: getIt<DioCrud>()),
  );

  /// Blocs

  getIt.registerFactory(
        () => TodoBloc(),
  );

  getIt.registerFactory(
        () => PostBloc(getIt<PostRepositories>()),
  );

  getIt.registerFactory(
        () => SewaBloc(repository: getIt<SewaverseRepository>()),
  );

  getIt.registerFactory(
        () => BookingBloc(
      bookingRepository: getIt<BookingRepository>(),
    ),
  );
}