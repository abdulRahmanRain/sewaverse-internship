import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../data/repository/user_mode_repo.dart';
import '../../domain/models/user_model_2.dart';
import 'user_mode_event.dart';
import 'user_mode_state.dart';

class UserModeBloc extends Bloc<UserModeEvent, UserModeState> {
  final UserRepository repository;

  List<UserModel2> _users = [];
  String _currentType = 'Normal';

  UserModeBloc({required this.repository})
      : super(const UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<RefreshUsers>(_onRefreshUsers);
    on<ChangeUserType>(_onChangeUserType);
  }


  Future<void> _onFetchUsers(
      FetchUsers event,
      Emitter<UserModeState> emit,
      ) async {
    _loadHiveType();

    emit(UserLoading(userType: _currentType));

    _users = await repository.loadUsersNormal();

    emit(UserLoaded(
      users: _users,
      userType: _currentType,
    ));
  }


  Future<void> _onRefreshUsers(
      RefreshUsers event,
      Emitter<UserModeState> emit,
      ) async {
    emit(UserLoading(userType: _currentType));

    _users = await repository.loadUsersNormal();

    emit(UserLoaded(
      users: _users,
      userType: _currentType,
    ));
  }


  Future<void> _onChangeUserType(
      ChangeUserType event,
      Emitter<UserModeState> emit,
      ) async {
    if (event.userType == _currentType) return;

    _currentType = event.userType;

    final box = Hive.box('authBox');
    box.put('userType', _currentType);

    emit(UserLoading(userType: _currentType));

    _users = await repository.loadUsersNormal();

    emit(UserLoaded(
      users: _users,
      userType: _currentType,
    ));
  }


  void _loadHiveType() {
    final box = Hive.box('authBox');
    _currentType = box.get('userType', defaultValue: 'Normal');
  }
}