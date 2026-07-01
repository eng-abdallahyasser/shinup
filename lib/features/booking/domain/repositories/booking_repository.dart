import 'package:shineup/features/booking/data/models/booking_model.dart';

abstract class BookingRepository {
  Future<PaginatedBookingsResponse> getBookings({int page = 1, int limit = 20});
  Future<void> cancelBooking(String bookingId, {required String reason});
}
