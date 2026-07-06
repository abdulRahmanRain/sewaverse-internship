import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/auth_service/auth_services.dart';
import 'auth_services_event.dart';
import 'auth_services_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    // SignUp
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _authService.signUp(event.email, event.password);
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // SignIn
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _authService.signIn(event.email, event.password);
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // SignOut
    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.signOut();
        emit(AuthUnauthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // Check current user
    on<AuthCheckRequested>((event, emit) {
      final user = _authService.currentUser;
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    // Switch account
    on<SwitchAccountRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final password = await _authService.getPassword(event.email);
        if (password == null) {
          emit(AuthError("No saved password found for ${event.email}. Please login again."));
          return;
        }
        final user = await _authService.switchAccount(event.email, password);
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // List saved accounts
    on<ListAccountsRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final accounts = await _authService.getSavedAccounts();
        emit(AuthAccountsListed(accounts));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
