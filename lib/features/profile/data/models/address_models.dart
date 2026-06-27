class AddressModel {
  final String id;
  final String userId;
  final String title;
  final String city;
  final String area;
  final String street;
  final String buildingNumber;
  final double latitude;
  final double longitude;
  final String? notes;
  final bool defaultIs;
  final String atCreated;
  final String atUpdated;

  const AddressModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.city,
    required this.area,
    required this.street,
    required this.buildingNumber,
    required this.latitude,
    required this.longitude,
    this.notes,
    this.defaultIs = false,
    this.atCreated = '',
    this.atUpdated = '',
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      city: json['city'] as String? ?? '',
      area: json['area'] as String? ?? '',
      street: json['street'] as String? ?? '',
      buildingNumber: json['buildingNumber'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      notes: json['notes'] as String?,
      defaultIs: json['defaultIs'] as bool? ?? false,
      atCreated: json['atCreated'] as String? ?? '',
      atUpdated: json['atUpdated'] as String? ?? '',
    );
  }

  String get displayAddress => '$street, $area, $city';
}

class AddAddressRequest {
  final String title;
  final String city;
  final String area;
  final String street;
  final String buildingNumber;
  final double latitude;
  final double longitude;
  final String? notes;
  final bool defaultIs;

  const AddAddressRequest({
    required this.title,
    required this.city,
    required this.area,
    required this.street,
    required this.buildingNumber,
    required this.latitude,
    required this.longitude,
    this.notes,
    this.defaultIs = false,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'city': city,
        'area': area,
        'street': street,
        'buildingNumber': buildingNumber,
        'latitude': latitude,
        'longitude': longitude,
        if (notes != null && notes!.isNotEmpty) 'notes': notes,
        'defaultIs': defaultIs,
      };
}

class UpdateAddressRequest {
  final String? title;
  final String? city;
  final String? area;
  final String? street;
  final String? buildingNumber;
  final double? latitude;
  final double? longitude;
  final String? notes;

  const UpdateAddressRequest({
    this.title,
    this.city,
    this.area,
    this.street,
    this.buildingNumber,
    this.latitude,
    this.longitude,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (title != null) map['title'] = title;
    if (city != null) map['city'] = city;
    if (area != null) map['area'] = area;
    if (street != null) map['street'] = street;
    if (buildingNumber != null) map['buildingNumber'] = buildingNumber;
    if (latitude != null) map['latitude'] = latitude;
    if (longitude != null) map['longitude'] = longitude;
    if (notes != null) map['notes'] = notes;
    return map;
  }
}
