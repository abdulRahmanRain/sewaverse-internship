import 'package:equatable/equatable.dart';
import '../../domain/models/sewa_model/sewaverse_model.dart';

abstract class SewaverseState extends Equatable {
  const SewaverseState();

  @override
  List<Object?> get props => [];
}

class InitialState extends SewaverseState {
  const InitialState();
}

class LoadingState extends SewaverseState {
  const LoadingState();
}

class LoadedState extends SewaverseState {
  final SewaverseModel service;

  const LoadedState(this.service);

  @override
  List<Object?> get props => [service];
}

class ErrorState extends SewaverseState {
  final String errorMessage;

  const ErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}