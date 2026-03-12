import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../storage/local_storage/hive_storage.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {


  LoginBloc() : super(LoginInitial()) {
    on<UserLoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        await HiveStorage.saveUser(event.userName);
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(message: e.toString()));
      }
    });
  }

}