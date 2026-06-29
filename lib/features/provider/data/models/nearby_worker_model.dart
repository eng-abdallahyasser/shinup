class NearbyWorkerResult {
  final String providerId;
  final String typeProvider;
  final String providerName;
  final String? companyName;
  final String priceMode;
  final String providerMemberId;
  final String memberName;
  final String memberDisplayName;
  final double distanceMeters;
  final int minutesEta;
  final double latitude;
  final double longitude;
  final double accuracy;
  final double heading;
  final double speed;
  final List<WorkerServiceItem> items;

  const NearbyWorkerResult({
    required this.providerId,
    required this.typeProvider,
    required this.providerName,
    this.companyName,
    required this.priceMode,
    required this.providerMemberId,
    required this.memberName,
    required this.memberDisplayName,
    required this.distanceMeters,
    required this.minutesEta,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.heading,
    required this.speed,
    required this.items,
  });

  factory NearbyWorkerResult.fromJson(Map<String, dynamic> json) {
    return NearbyWorkerResult(
      providerId: json['providerId'] as String? ?? '',
      typeProvider: json['typeProvider'] as String? ?? '',
      providerName: json['providerName'] as String? ?? '',
      companyName: json['companyName'] as String?,
      priceMode: json['priceMode'] as String? ?? '',
      providerMemberId: json['providerMemberId'] as String? ?? '',
      memberName: json['memberName'] as String? ?? '',
      memberDisplayName: json['memberDisplayName'] as String? ?? '',
      distanceMeters: (json['distanceMeters'] as num?)?.toDouble() ?? 0.0,
      minutesEta: (json['minutesEta'] as num?)?.toInt() ?? 0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0.0,
      heading: (json['heading'] as num?)?.toDouble() ?? 0.0,
      speed: (json['speed'] as num?)?.toDouble() ?? 0.0,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) =>
                  WorkerServiceItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class WorkerServiceItem {
  final String serviceId;
  final String serviceName;
  final String providerServiceId;
  final String providerServicePriceId;
  final String priceCustomer;
  final String currency;
  final int minutesDuration;

  const WorkerServiceItem({
    required this.serviceId,
    required this.serviceName,
    required this.providerServiceId,
    required this.providerServicePriceId,
    required this.priceCustomer,
    required this.currency,
    required this.minutesDuration,
  });

  factory WorkerServiceItem.fromJson(Map<String, dynamic> json) {
    return WorkerServiceItem(
      serviceId: json['serviceId'] as String? ?? '',
      serviceName: json['serviceName'] as String? ?? '',
      providerServiceId: json['providerServiceId'] as String? ?? '',
      providerServicePriceId: json['providerServicePriceId'] as String? ?? '',
      priceCustomer: json['priceCustomer'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      minutesDuration: (json['minutesDuration'] as num?)?.toInt() ?? 0,
    );
  }
}
