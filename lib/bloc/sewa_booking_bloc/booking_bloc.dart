import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/sewa_booking_repo.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;

  BookingBloc({required this.bookingRepository}) : super(BookingInitial()) {
    on<FetchBookingEvent>((event, emit) async {
      emit(BookingLoading());
      try {
        final data = await bookingRepository.fetchOfferedService(id: event.id);
        emit(BookingLoaded(data));
      } catch (e) {
        emit(BookingError(e.toString()));
      }
    });
  }
}