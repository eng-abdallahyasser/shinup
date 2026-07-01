import 'package:shineup/features/provider/data/models/nearby_worker_model.dart';

class NearbyWorkersResponse {
  final List<NearbyWorkerResult> results;
  final NearbyWorkersMeta meta;

  const NearbyWorkersResponse({
    required this.results,
    required this.meta,
  });

  factory NearbyWorkersResponse.fromJson(Map<String, dynamic> json) {
    return NearbyWorkersResponse(
      results: (json['results'] as List<dynamic>?)
              ?.map((e) =>
                  NearbyWorkerResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: NearbyWorkersMeta.fromJson(
          json['meta'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class NearbyWorkersMeta {
  final double radiusMeters;
  final int limit;
  final int count;

  const NearbyWorkersMeta({
    required this.radiusMeters,
    required this.limit,
    required this.count,
  });

  factory NearbyWorkersMeta.fromJson(Map<String, dynamic> json) {
    return NearbyWorkersMeta(
      radiusMeters: (json['radiusMeters'] as num?)?.toDouble() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 0,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );
  }
}
