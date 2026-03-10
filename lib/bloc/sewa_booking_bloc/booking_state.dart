
import '../../domain/models/offered_service_response.dart';

abstract class BookingState {}
class BookingInitial extends BookingState {}
class BookingLoading extends BookingState {}
class BookingLoaded extends BookingState {
  final OfferedServiceResponse data;
  BookingLoaded(this.data);
}
class BookingError extends BookingState {
  final String message;
  BookingError(this.message);
}