class CreateBookingRequest {
  final String bookingTimeMode;
  final DateTime? scheduledAt;
  final String providerMemberId;
  final String carId;
  final String addressId;
  final String? notes;
  final String? instructions;
  final List<BookingItemRequest> items;

  const CreateBookingRequest({
    required this.bookingTimeMode,
    this.scheduledAt,
    required this.providerMemberId,
    required this.carId,
    required this.addressId,
    this.notes,
    this.instructions,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'bookingTimeMode': bookingTimeMode,
      'providerMemberId': providerMemberId,
      'carId': carId,
      'addressId': addressId,
      'items': items.map((e) => e.toJson()).toList(),
      if (notes != null && notes!.isNotEmpty) 'notes': notes,
      if (instructions != null && instructions!.isNotEmpty)
        'instructions': instructions,
    };
    if (bookingTimeMode == 'SCHEDULED' && scheduledAt != null) {
      map['scheduledAt'] = scheduledAt!.toUtc().toIso8601String();
    }
    return map;
  }
}

class BookingItemRequest {
  final String providerServiceId;

  const BookingItemRequest({required this.providerServiceId});

  Map<String, dynamic> toJson() => {'providerServiceId': providerServiceId};
}
