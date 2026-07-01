import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shineup/core/network/api_client.dart';
import 'package:shineup/features/booking/data/models/booking_model.dart';
import 'package:shineup/features/booking/domain/repositories/booking_repository.dart';

enum BookingFilter { upcoming, past, cancelled }

enum BookingStatus { initial, loading, loaded, error, loadingMore }

class BookingState extends Equatable {
  final BookingStatus status;
  final BookingFilter filter;
  final List<BookingModel> bookings;
  final List<BookingModel> filteredBookings;
  final String? errorMessage;
  final String? cancelErrorMessage;
  final String? cancelSuccessMessage;
  final String? cancellingBookingId;
  final int page;
  final int totalPages;
  final bool hasMore;

  const BookingState({
    this.status = BookingStatus.initial,
    this.filter = BookingFilter.upcoming,
    this.bookings = const [],
    this.filteredBookings = const [],
    this.errorMessage,
    this.cancelErrorMessage,
    this.cancelSuccessMessage,
    this.cancellingBookingId,
    this.page = 1,
    this.totalPages = 1,
    this.hasMore = false,
  });

  BookingState copyWith({
    BookingStatus? status,
    BookingFilter? filter,
    List<BookingModel>? bookings,
    List<BookingModel>? filteredBookings,
    String? errorMessage,
    String? cancelErrorMessage,
    String? cancelSuccessMessage,
    String? cancellingBookingId,
    int? page,
    int? totalPages,
    bool? hasMore,
  }) {
    return BookingState(
      status: status ?? this.status,
      filter: filter ?? this.filter,
      bookings: bookings ?? this.bookings,
      filteredBookings: filteredBookings ?? this.filteredBookings,
      errorMessage: errorMessage,
      cancelErrorMessage: cancelErrorMessage,
      cancelSuccessMessage: cancelSuccessMessage,
      cancellingBookingId: cancellingBookingId ?? this.cancellingBookingId,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [
        status,
        filter,
        bookings,
        filteredBookings,
        errorMessage,
        cancelErrorMessage,
        cancelSuccessMessage,
        cancellingBookingId,
        page,
        totalPages,
        hasMore,
      ];
}

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository _repository;

  BookingCubit({required BookingRepository repository})
      : _repository = repository,
        super(const BookingState());

  Future<void> loadBookings() async {
    emit(state.copyWith(status: BookingStatus.loading, errorMessage: null));
    try {
      final response = await _repository.getBookings(page: 1, limit: 20);
      final bookings = response.items;
      _applyFilter(
        bookings: bookings,
        filter: state.filter,
        page: response.page,
        totalPages: response.totalPages,
      );
    } on ApiException catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      log('LOAD BOOKINGS ERROR: $e');
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: 'Failed to load bookings',
      ));
    }
  }

  Future<void> loadMoreBookings() async {
    if (!state.hasMore || state.status == BookingStatus.loadingMore) return;
    final nextPage = state.page + 1;
    emit(state.copyWith(status: BookingStatus.loadingMore));
    try {
      final response =
          await _repository.getBookings(page: nextPage, limit: 20);
      final allBookings = [...state.bookings, ...response.items];
      _applyFilter(
        bookings: allBookings,
        filter: state.filter,
        page: response.page,
        totalPages: response.totalPages,
      );
    } on ApiException catch (e) {
      emit(state.copyWith(
        status: BookingStatus.loaded,
        errorMessage: e.message,
      ));
    } catch (e) {
      log('LOAD MORE BOOKINGS ERROR: $e');
      emit(state.copyWith(
        status: BookingStatus.loaded,
      ));
    }
  }

  void changeFilter(BookingFilter filter) {
    _applyFilter(
      bookings: state.bookings,
      filter: filter,
      page: state.page,
      totalPages: state.totalPages,
    );
  }

  void _applyFilter({
    required List<BookingModel> bookings,
    required BookingFilter filter,
    required int page,
    required int totalPages,
  }) {
    final filtered = switch (filter) {
      BookingFilter.upcoming => bookings.where((b) {
          final status = b.customerStatus.code;
          if (status == 'CANCELLED' || status == 'COMPLETED') return false;
          return true;
        }),
      BookingFilter.past => bookings.where((b) {
          return b.customerStatus.code == 'COMPLETED';
        }),
      BookingFilter.cancelled => bookings.where((b) {
          return b.customerStatus.code == 'CANCELLED';
        }),
    }.toList();

    emit(state.copyWith(
      status: BookingStatus.loaded,
      bookings: bookings,
      filteredBookings: filtered,
      filter: filter,
      page: page,
      totalPages: totalPages,
      hasMore: page < totalPages,
    ));
  }

  Future<void> cancelBooking(String bookingId) async {
    emit(state.copyWith(
      cancellingBookingId: bookingId,
      cancelErrorMessage: null,
      cancelSuccessMessage: null,
    ));
    try {
      await _repository.cancelBooking(
        bookingId,
        reason: 'Customer changed plans',
      );
      emit(state.copyWith(
        cancellingBookingId: null,
        cancelSuccessMessage: 'Booking cancelled',
      ));
      loadBookings();
    } on ApiException catch (e) {
      emit(state.copyWith(
        cancellingBookingId: null,
        cancelErrorMessage: e.message,
      ));
    } catch (e) {
      log('CANCEL BOOKING ERROR: $e');
      emit(state.copyWith(
        cancellingBookingId: null,
        cancelErrorMessage: 'Failed to cancel booking',
      ));
    }
  }

  void dismissCancelMessage() {
    emit(state.copyWith(
      cancelErrorMessage: null,
      cancelSuccessMessage: null,
    ));
  }
}
