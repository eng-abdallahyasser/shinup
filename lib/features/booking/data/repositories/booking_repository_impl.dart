import 'package:shineup/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:shineup/features/booking/data/models/booking_model.dart';
import 'package:shineup/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource _remoteDataSource;

  BookingRepositoryImpl(this._remoteDataSource);

  @override
  Future<PaginatedBookingsResponse> getBookings({
    int page = 1,
    int limit = 20,
  }) async {
    return _remoteDataSource.getBookings(page: page, limit: limit);
  }

  @override
  Future<void> cancelBooking(String bookingId, {required String reason}) async {
    await _remoteDataSource.cancelBooking(bookingId, reason: reason);
  }
}
