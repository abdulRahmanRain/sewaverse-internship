import 'package:flutter_bloc/flutter_bloc.dart';

import '../../storage/local_storage/hive_storage.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final HiveStorage hiveStorage;

  LoginBloc({required this.hiveStorage}) : super(LoginInitial()) {
    on<UserLoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        await hiveStorage.saveUser(event.userName);
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(message: e.toString()));
      }
    });
  }
}