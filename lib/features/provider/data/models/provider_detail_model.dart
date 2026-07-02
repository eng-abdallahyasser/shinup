class ProviderDetailModel {
  final String id;
  final String typeProvider;
  final String nameBusiness;
  final String description;
  final bool availableIs;
  final DateTime atApproved;
  final DateTime atCreated;
  final List<ProviderServiceSummary> servicesSummary;
  // TODO: when backend adds providerMemberId to /discover/providers/{id} response
  final String? providerMemberId;

  const ProviderDetailModel({
    required this.id,
    required this.typeProvider,
    required this.nameBusiness,
    required this.description,
    required this.availableIs,
    required this.atApproved,
    required this.atCreated,
    required this.servicesSummary,
    this.providerMemberId,
  });

  factory ProviderDetailModel.fromJson(Map<String, dynamic> json) {
    return ProviderDetailModel(
      id: json['id'] as String? ?? '',
      typeProvider: json['typeProvider'] as String? ?? '',
      nameBusiness: json['nameBusiness'] as String? ?? '',
      description: json['description'] as String? ?? '',
      availableIs: json['availableIs'] as bool? ?? false,
      atApproved: _parseDateTime(json['atApproved']),
      atCreated: _parseDateTime(json['atCreated']),
      servicesSummary: (json['servicesSummary'] as List<dynamic>?)
              ?.map((e) =>
                  ProviderServiceSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      providerMemberId: json['providerMemberId'] as String?,
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime(0);
    if (value is String) return DateTime.tryParse(value) ?? DateTime(0);
    return DateTime(0);
  }
}

class ProviderServiceSummary {
  final String id;
  final String providerId;
  final String serviceId;
  final String displayName;
  final String description;
  final bool availableIs;
  final ServiceInfo service;
  final PriceSummaryInfo priceSummary;

  const ProviderServiceSummary({
    required this.id,
    required this.providerId,
    required this.serviceId,
    required this.displayName,
    required this.description,
    required this.availableIs,
    required this.service,
    required this.priceSummary,
  });

  factory ProviderServiceSummary.fromJson(Map<String, dynamic> json) {
    return ProviderServiceSummary(
      id: json['id'] as String? ?? '',
      providerId: json['providerId'] as String? ?? '',
      serviceId: json['serviceId'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      availableIs: json['availableIs'] as bool? ?? false,
      service:
          ServiceInfo.fromJson(json['service'] as Map<String, dynamic>? ?? {}),
      priceSummary: PriceSummaryInfo.fromJson(
          json['priceSummary'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class ServiceInfo {
  final String id;
  final String categoryId;
  final String name;
  final String type;
  final String description;
  final String? image;
  final CategoryInfo category;

  const ServiceInfo({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.type,
    required this.description,
    this.image,
    required this.category,
  });

  factory ServiceInfo.fromJson(Map<String, dynamic> json) {
    return ServiceInfo(
      id: json['id'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: json['image'] as String?,
      category: CategoryInfo.fromJson(
          json['category'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class CategoryInfo {
  final String id;
  final String name;
  final String description;
  final String? image;
  final int orderSort;

  const CategoryInfo({
    required this.id,
    required this.name,
    required this.description,
    this.image,
    required this.orderSort,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) {
    return CategoryInfo(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: json['image'] as String?,
      orderSort: (json['orderSort'] as num?)?.toInt() ?? 0,
    );
  }
}

class PriceSummaryInfo {
  final String providerServicePriceId;
  final String providerServiceId;
  final String? providerId;
  final String? providerNameBusiness;
  final String? serviceId;
  final String? serviceName;
  final String carTypeId;
  final String carTypeName;
  final double priceProvider;
  final int durationMinutes;
  final DateTime fromEffective;
  final DateTime? toEffective;

  const PriceSummaryInfo({
    required this.providerServicePriceId,
    required this.providerServiceId,
    this.providerId,
    this.providerNameBusiness,
    this.serviceId,
    this.serviceName,
    required this.carTypeId,
    required this.carTypeName,
    required this.priceProvider,
    required this.durationMinutes,
    required this.fromEffective,
    this.toEffective,
  });

  factory PriceSummaryInfo.fromJson(Map<String, dynamic> json) {
    return PriceSummaryInfo(
      providerServicePriceId: json['providerServicePriceId'] as String? ?? '',
      providerServiceId: json['providerServiceId'] as String? ?? '',
      providerId: json['providerId'] as String?,
      providerNameBusiness: json['providerNameBusiness'] as String?,
      serviceId: json['serviceId'] as String?,
      serviceName: json['serviceName'] as String?,
      carTypeId: json['carTypeId'] as String? ?? '',
      carTypeName: json['carTypeName'] as String? ?? '',
      priceProvider: (json['priceProvider'] as num?)?.toDouble() ?? 0.0,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 0,
      fromEffective: _parseDateTime(json['fromEffective']),
      toEffective: json['toEffective'] != null
          ? _parseDateTime(json['toEffective'])
          : null,
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime(0);
    if (value is String) return DateTime.tryParse(value) ?? DateTime(0);
    return DateTime(0);
  }
}
