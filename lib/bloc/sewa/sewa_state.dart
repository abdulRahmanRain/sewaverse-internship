
import 'package:todo_app/domain/sewa_model.dart';

abstract class SewaState {

}

// Initial state
class SewaInitial extends SewaState {}

// Loading state
class SewaLoading extends SewaState {}

// Loaded state with data
class SewaLoaded extends SewaState {
  final List<SewaModel> sewaList;

  SewaLoaded(this.sewaList);
}

// Error state
class SewaError extends SewaState {
  final String message;

  SewaError(this.message);
}