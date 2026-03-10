abstract class BookingEvent {}
class FetchBookingEvent extends BookingEvent {
  final String id;
  FetchBookingEvent(this.id);
}