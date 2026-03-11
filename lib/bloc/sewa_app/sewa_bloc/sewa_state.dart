


import '../../../domain/models/sewa_model/sewaverse_model.dart';

abstract class SewaState {

}

// Initial state
class SewaInitial extends SewaState {}

// Loading state
class SewaLoading extends SewaState {}

// Loaded state with data
class SewaLoaded extends SewaState {
  final SewaverseModel sewaModel;

  SewaLoaded(this.sewaModel);
}

// Error state
class SewaError extends SewaState {
  final String message;

  SewaError(this.message);
}