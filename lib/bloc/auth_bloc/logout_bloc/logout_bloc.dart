import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/bloc/auth_bloc/logout_bloc/logout_event.dart';

import '../../../services/auth_service.dart';
import 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {

  LogoutBloc() : super(LogoutInitial()) {

    on<LogoutConfirmed>((event, emit) async {
      emit(LogoutLoading());

      try {
        await Auth.isUserLogOut;
        emit(LogoutSuccess());
      } catch (e) {
        emit(LogoutFailure(e.toString()));
      }
    });

  }
}