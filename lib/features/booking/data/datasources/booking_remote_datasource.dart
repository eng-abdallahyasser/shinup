import 'package:shinup/core/network/api_client.dart';
import 'package:shinup/features/booking/data/models/booking_model.dart';

class BookingRemoteDataSource {
  final ApiClient _client;

  BookingRemoteDataSource(this._client);

  Future<List<BookingModel>> getBookings() async {
    final data = await _client.getList('/customers/me/bookings');
    return data
        .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<BookingModel> getBooking(String bookingId) async {
    final data = await _client.get('/customers/me/bookings/$bookingId');
    return BookingModel.fromJson(data);
  }

  Future<BookingModel> createBooking(CreateBookingRequest request) async {
    final data = await _client.post(
      '/customers/me/bookings',
      body: request.toJson(),
    );
    return BookingModel.fromJson(data);
  }

  Future<BookingModel> updateBooking(
      String bookingId, Map<String, dynamic> updates) async {
    final data = await _client.patch(
      '/customers/me/bookings/$bookingId',
      body: updates,
    );
    return BookingModel.fromJson(data);
  }

  Future<void> cancelBooking(String bookingId) async {
    await _client.post('/customers/me/bookings/$bookingId/cancel');
  }
}
