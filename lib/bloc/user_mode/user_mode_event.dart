import 'package:equatable/equatable.dart';

abstract class UserModeEvent extends Equatable {
  const UserModeEvent();

  @override
  List<Object?> get props => [];
}

class FetchUsers extends UserModeEvent {}

class ChangeUserType extends UserModeEvent {
  final String userType;

  const ChangeUserType({required this.userType});

  @override
  List<Object?> get props => [userType];
}