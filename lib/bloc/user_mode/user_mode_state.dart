import 'package:equatable/equatable.dart';

import '../../domain/models/UserModel.dart';
import '../../domain/models/user_model_2.dart';

abstract class UserModeState extends Equatable {
  final String userType;

  const UserModeState({this.userType = 'Normal'});

  @override
  List<Object?> get props => [userType];
}

class UserInitial extends UserModeState {
  const UserInitial() : super(userType: 'Normal');
}

class UserLoading extends UserModeState {
  const UserLoading({required String userType})
      : super(userType: userType);
}

class UserLoaded extends UserModeState {
  final List<UserModel2> users;

  const UserLoaded({
    required this.users,
    required String userType,
  }) : super(userType: userType);

  @override
  List<Object?> get props => [users, userType];
}

class PremiumUserLoaded extends UserModeState{
  final List<UserModel> premiumUsers;
  const PremiumUserLoaded({
    required this.premiumUsers,
    required String userType
}) : super(userType: userType);
}

class UserError extends UserModeState {
  final String message;

  const UserError({
    required this.message,
    required String userType,
  }) : super(userType: userType);

  @override
  List<Object?> get props => [message, userType];
}