import 'package:shinup/features/booking/data/models/booking_model.dart';

abstract class BookingRepository {
  Future<List<BookingModel>> getBookings();
  Future<BookingModel> getBooking(String bookingId);
  Future<BookingModel> createBooking(CreateBookingRequest request);
  Future<BookingModel> updateBooking(String bookingId, Map<String, dynamic> updates);
  Future<void> cancelBooking(String bookingId);
}
