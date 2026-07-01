import 'package:shineup/core/network/api_client.dart';
import 'package:shineup/features/provider/data/models/nearby_worker_model.dart';

class ProviderRemoteDataSource {
  final ApiClient _client;

  ProviderRemoteDataSource(this._client);

  Future<List<NearbyWorkerResult>> getNearbyWorkers({
    required double latitude,
    required double longitude,
    required List<String> serviceIds,
    int limit = 10,
  }) async {
    final serviceIdsParam = serviceIds.join(',');
    final data = await _client.get(
      '/customers/me/nearby-workers'
      '?latitude=$latitude'
      '&longitude=$longitude'
      '&serviceIds=$serviceIdsParam'
      '&limit=$limit'
      '&bookingTimeMode=NOW',
    );
    final results = data['results'] as List<dynamic>? ?? [];
    return results
        .map((e) => NearbyWorkerResult.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
