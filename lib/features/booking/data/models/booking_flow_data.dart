import 'package:shineup/features/booking/data/models/create_booking_request.dart';

class BookingFlowData {
  final String providerId;
  final String? providerMemberId;
  final String providerName;
  final String providerDescription;
  final bool availableIs;
  final List<SelectedService> selectedServices;
  final double totalCost;
  final int totalDurationMinutes;
  final String bookingTimeMode;
  final DateTime? scheduledAt;
  final String? carId;
  final String? carDisplay;
  final String? addressId;
  final String? addressDisplay;
  final String? notes;
  final String? instructions;

  const BookingFlowData({
    required this.providerId,
    this.providerMemberId,
    required this.providerName,
    this.providerDescription = '',
    this.availableIs = false,
    required this.selectedServices,
    this.totalCost = 0,
    this.totalDurationMinutes = 0,
    this.bookingTimeMode = 'NOW',
    this.scheduledAt,
    this.carId,
    this.carDisplay,
    this.addressId,
    this.addressDisplay,
    this.notes,
    this.instructions,
  });

  BookingFlowData copyWith({
    String? providerId,
    String? providerMemberId,
    String? providerName,
    String? providerDescription,
    bool? availableIs,
    List<SelectedService>? selectedServices,
    double? totalCost,
    int? totalDurationMinutes,
    String? bookingTimeMode,
    DateTime? scheduledAt,
    String? carId,
    String? carDisplay,
    String? addressId,
    String? addressDisplay,
    String? notes,
    String? instructions,
  }) {
    return BookingFlowData(
      providerId: providerId ?? this.providerId,
      providerMemberId: providerMemberId ?? this.providerMemberId,
      providerName: providerName ?? this.providerName,
      providerDescription: providerDescription ?? this.providerDescription,
      availableIs: availableIs ?? this.availableIs,
      selectedServices: selectedServices ?? this.selectedServices,
      totalCost: totalCost ?? this.totalCost,
      totalDurationMinutes: totalDurationMinutes ?? this.totalDurationMinutes,
      bookingTimeMode: bookingTimeMode ?? this.bookingTimeMode,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      carId: carId ?? this.carId,
      carDisplay: carDisplay ?? this.carDisplay,
      addressId: addressId ?? this.addressId,
      addressDisplay: addressDisplay ?? this.addressDisplay,
      notes: notes ?? this.notes,
      instructions: instructions ?? this.instructions,
    );
  }

  CreateBookingRequest toCreateRequest() {
    return CreateBookingRequest(
      bookingTimeMode: bookingTimeMode,
      scheduledAt: scheduledAt,
      providerMemberId: providerMemberId ?? '',
      carId: carId ?? '',
      addressId: addressId ?? '',
      notes: notes,
      instructions: instructions,
      items: selectedServices
          .map((s) => BookingItemRequest(providerServiceId: s.providerServiceId))
          .toList(),
    );
  }
}

class SelectedService {
  final String providerServiceId;
  final String name;
  final double price;
  final int durationMinutes;

  const SelectedService({
    required this.providerServiceId,
    required this.name,
    required this.price,
    required this.durationMinutes,
  });
}
