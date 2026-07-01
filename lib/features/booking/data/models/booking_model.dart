class PaginatedBookingsResponse {
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final List<BookingModel> items;

  const PaginatedBookingsResponse({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.items,
  });

  factory PaginatedBookingsResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedBookingsResponse(
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 20,
      total: json['total'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class BookingModel {
  final String id;
  final String codeBooking;
  final String bookingTimeMode;
  final DateTime? scheduledAt;
  final String providerMemberId;
  final String providerName;
  final String companyName;
  final String memberName;
  final String memberDisplayName;
  final BookingCar? car;
  final BookingLocation? location;
  final List<BookingItem> items;
  final String totalPriceCustomer;
  final int totalMinutesDuration;
  final CustomerStatus customerStatus;
  final String? notes;
  final DateTime? atCreated;

  const BookingModel({
    required this.id,
    required this.codeBooking,
    required this.bookingTimeMode,
    this.scheduledAt,
    required this.providerMemberId,
    required this.providerName,
    required this.companyName,
    required this.memberName,
    required this.memberDisplayName,
    this.car,
    this.location,
    required this.items,
    required this.totalPriceCustomer,
    required this.totalMinutesDuration,
    required this.customerStatus,
    this.notes,
    this.atCreated,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String? ?? '',
      codeBooking: json['codeBooking'] as String? ?? '',
      bookingTimeMode: json['bookingTimeMode'] as String? ?? '',
      scheduledAt: json['scheduledAt'] != null
          ? DateTime.tryParse(json['scheduledAt'] as String)
          : null,
      providerMemberId: json['providerMemberId'] as String? ?? '',
      providerName: json['providerName'] as String? ?? '',
      companyName: json['companyName'] as String? ?? '',
      memberName: json['memberName'] as String? ?? '',
      memberDisplayName: json['memberDisplayName'] as String? ?? '',
      car: json['car'] != null
          ? BookingCar.fromJson(json['car'] as Map<String, dynamic>)
          : null,
      location: json['location'] != null
          ? BookingLocation.fromJson(json['location'] as Map<String, dynamic>)
          : null,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => BookingItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalPriceCustomer: json['totalPriceCustomer'] as String? ?? '',
      totalMinutesDuration: json['totalMinutesDuration'] as int? ?? 0,
      customerStatus: CustomerStatus.fromJson(
          json['customerStatus'] as Map<String, dynamic>? ?? {}),
      notes: json['notes'] as String?,
      atCreated: json['atCreated'] != null
          ? DateTime.tryParse(json['atCreated'] as String)
          : null,
    );
  }

  String get servicesLabel =>
      items.map((e) => e.serviceLabel).join(', ');
}

class BookingCar {
  final String id;
  final String brand;
  final String model;
  final String plateNumber;

  const BookingCar({
    required this.id,
    required this.brand,
    required this.model,
    required this.plateNumber,
  });

  factory BookingCar.fromJson(Map<String, dynamic> json) {
    return BookingCar(
      id: json['id'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      model: json['model'] as String? ?? '',
      plateNumber: json['plateNumber'] as String? ?? '',
    );
  }
}

class BookingLocation {
  final String labelLocation;
  final String city;
  final String area;
  final String textAddress;
  final double latitude;
  final double longitude;
  final String? instructions;

  const BookingLocation({
    required this.labelLocation,
    required this.city,
    required this.area,
    required this.textAddress,
    required this.latitude,
    required this.longitude,
    this.instructions,
  });

  factory BookingLocation.fromJson(Map<String, dynamic> json) {
    return BookingLocation(
      labelLocation: json['labelLocation'] as String? ?? '',
      city: json['city'] as String? ?? '',
      area: json['area'] as String? ?? '',
      textAddress: json['textAddress'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      instructions: json['instructions'] as String?,
    );
  }
}

class BookingItem {
  final String id;
  final String serviceName;
  final String serviceLabel;
  final String priceCustomer;
  final String currency;
  final int minutesDuration;
  final String carTypeLabel;

  const BookingItem({
    required this.id,
    required this.serviceName,
    required this.serviceLabel,
    required this.priceCustomer,
    required this.currency,
    required this.minutesDuration,
    required this.carTypeLabel,
  });

  factory BookingItem.fromJson(Map<String, dynamic> json) {
    return BookingItem(
      id: json['id'] as String? ?? '',
      serviceName: json['serviceName'] as String? ?? '',
      serviceLabel: json['serviceLabel'] as String? ?? '',
      priceCustomer: json['priceCustomer'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      minutesDuration: json['minutesDuration'] as int? ?? 0,
      carTypeLabel: json['carTypeLabel'] as String? ?? '',
    );
  }
}

class CustomerStatus {
  final String code;
  final String label;

  const CustomerStatus({
    required this.code,
    required this.label,
  });

  factory CustomerStatus.fromJson(Map<String, dynamic> json) {
    return CustomerStatus(
      code: json['code'] as String? ?? '',
      label: json['label'] as String? ?? '',
    );
  }
}

class CancelBookingRequest {
  final String reason;

  const CancelBookingRequest({required this.reason});

  Map<String, dynamic> toJson() => {'reason': reason};
}
