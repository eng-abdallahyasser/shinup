class ProviderDetailModel {
  final String id;
  final String providerMemberId;
  final String typeProvider;
  final String providerName;
  final String? companyName;
  final String description;
  final String? providerLogoUrl;
  final String? providerCoverUrl;
  final String memberName;
  final String memberDisplayName;
  final String? memberBio;
  final String? memberAvatarUrl;
  final String affiliationLabel;
  final RatingInfo rating;
  final int completedBookingsCount;
  final List<ServiceCategory> serviceCategories;
  final List<ProviderServiceSummary> servicesSummary;
  final bool availableIs;
  final DateTime joinedAt;

  const ProviderDetailModel({
    required this.id,
    required this.providerMemberId,
    required this.typeProvider,
    required this.providerName,
    this.companyName,
    required this.description,
    this.providerLogoUrl,
    this.providerCoverUrl,
    required this.memberName,
    required this.memberDisplayName,
    this.memberBio,
    this.memberAvatarUrl,
    required this.affiliationLabel,
    required this.rating,
    required this.completedBookingsCount,
    required this.serviceCategories,
    required this.servicesSummary,
    required this.availableIs,
    required this.joinedAt,
  });

  factory ProviderDetailModel.fromJson(Map<String, dynamic> json) {
    return ProviderDetailModel(
      id: json['providerId'] as String? ?? '',
      providerMemberId: json['providerMemberId'] as String? ?? '',
      typeProvider: json['typeProvider'] as String? ?? '',
      providerName: json['providerName'] as String? ?? '',
      companyName: json['companyName'] as String?,
      description: json['providerDescription'] as String? ?? '',
      providerLogoUrl: json['providerLogoUrl'] as String?,
      providerCoverUrl: json['providerCoverUrl'] as String?,
      memberName: json['memberName'] as String? ?? '',
      memberDisplayName: json['memberDisplayName'] as String? ?? '',
      memberBio: json['memberBio'] as String?,
      memberAvatarUrl: json['memberAvatarUrl'] as String?,
      affiliationLabel: json['affiliationLabel'] as String? ?? '',
      rating: RatingInfo.fromJson(
          json['rating'] as Map<String, dynamic>? ?? {}),
      completedBookingsCount:
          (json['completedBookingsCount'] as num?)?.toInt() ?? 0,
      serviceCategories: (json['serviceCategories'] as List<dynamic>?)
              ?.map((e) =>
                  ServiceCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      servicesSummary: (json['servicesSummary'] as List<dynamic>?)
              ?.map((e) =>
                  ProviderServiceSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      availableIs: json['availableIs'] as bool? ?? false,
      joinedAt: _parseDateTime(json['joinedAt']),
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime(0);
    if (value is String) return DateTime.tryParse(value) ?? DateTime(0);
    return DateTime(0);
  }
}

class RatingInfo {
  final double? averageRating;
  final int reviewsCount;
  final double? providerAverageRating;
  final int providerReviewsCount;
  final double? memberAverageRating;
  final int memberReviewsCount;

  const RatingInfo({
    this.averageRating,
    required this.reviewsCount,
    this.providerAverageRating,
    required this.providerReviewsCount,
    this.memberAverageRating,
    required this.memberReviewsCount,
  });

  factory RatingInfo.fromJson(Map<String, dynamic> json) {
    return RatingInfo(
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      providerAverageRating:
          (json['providerAverageRating'] as num?)?.toDouble(),
      providerReviewsCount:
          (json['providerReviewsCount'] as num?)?.toInt() ?? 0,
      memberAverageRating:
          (json['memberAverageRating'] as num?)?.toDouble(),
      memberReviewsCount:
          (json['memberReviewsCount'] as num?)?.toInt() ?? 0,
    );
  }
}

class ServiceCategory {
  final String categoryId;
  final String categoryName;

  const ServiceCategory({
    required this.categoryId,
    required this.categoryName,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      categoryId: json['categoryId'] as String? ?? '',
      categoryName: json['categoryName'] as String? ?? '',
    );
  }
}

class ProviderServiceSummary {
  final String serviceId;
  final String serviceName;
  final String categoryId;
  final String categoryName;

  const ProviderServiceSummary({
    required this.serviceId,
    required this.serviceName,
    required this.categoryId,
    required this.categoryName,
  });

  factory ProviderServiceSummary.fromJson(Map<String, dynamic> json) {
    return ProviderServiceSummary(
      serviceId: json['serviceId'] as String? ?? '',
      serviceName: json['serviceName'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? '',
      categoryName: json['categoryName'] as String? ?? '',
    );
  }
}
