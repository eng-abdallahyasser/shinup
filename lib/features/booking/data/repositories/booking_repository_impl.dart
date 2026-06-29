import 'package:shinup/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:shinup/features/booking/data/models/booking_model.dart';
import 'package:shinup/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource _remoteDataSource;

  BookingRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<BookingModel>> getBookings() async {
    return _remoteDataSource.getBookings();
  }

  @override
  Future<BookingModel> getBooking(String bookingId) async {
    return _remoteDataSource.getBooking(bookingId);
  }

  @override
  Future<BookingModel> createBooking(CreateBookingRequest request) async {
    return _remoteDataSource.createBooking(request);
  }

  @override
  Future<BookingModel> updateBooking(
      String bookingId, Map<String, dynamic> updates) async {
    return _remoteDataSource.updateBooking(bookingId, updates);
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    await _remoteDataSource.cancelBooking(bookingId);
  }
}
