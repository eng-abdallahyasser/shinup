import 'package:shineup/core/network/api_client.dart';
import 'package:shineup/features/booking/data/models/booking_model.dart';
import 'package:shineup/features/booking/data/models/create_booking_request.dart';

class BookingRemoteDataSource {
  final ApiClient _client;

  BookingRemoteDataSource(this._client);

  Future<PaginatedBookingsResponse> getBookings({
    int page = 1,
    int limit = 20,
  }) async {
    final data = await _client.get('/bookings/me?page=$page&limit=$limit');
    return PaginatedBookingsResponse.fromJson(data);
  }

  Future<void> cancelBooking(
    String bookingId, {
    required String reason,
  }) async {
    await _client.post(
      '/bookings/me/$bookingId/cancel',
      body: CancelBookingRequest(reason: reason).toJson(),
    );
  }

  Future<BookingModel> createBooking(CreateBookingRequest request) async {
    final data = await _client.post('/bookings', body: request.toJson());
    return BookingModel.fromJson(data);
  }
}
