class NearbyProvider {
  final String id;
  final String name;
  final String service;
  final double distance;
  final double rating;
  final double latitude;
  final double longitude;
  final String status;
  final String? imageUrl;

  const NearbyProvider({
    required this.id,
    required this.name,
    required this.service,
    required this.distance,
    required this.rating,
    required this.latitude,
    required this.longitude,
    required this.status,
    this.imageUrl,
  });

  factory NearbyProvider.fromJson(Map<String, dynamic> json) {
    return NearbyProvider(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      service: json['service'] as String? ?? '',
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
