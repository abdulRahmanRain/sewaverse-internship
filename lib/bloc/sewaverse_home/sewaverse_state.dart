import '../../domain/models/sewa_model/sewaverse_model.dart';

abstract class SewaverseState {}

class InitialState extends SewaverseState {}

class LoadingState extends SewaverseState{}

class LoadedState extends SewaverseState{
  final SewaverseModel service;
  LoadedState(this.service);

}

class ErrorState extends SewaverseState{
  final String errorMessage;

  ErrorState(this.errorMessage);
}