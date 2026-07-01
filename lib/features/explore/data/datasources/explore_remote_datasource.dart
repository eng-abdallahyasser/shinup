import 'package:shineup/core/network/api_client.dart';
import 'package:shineup/features/explore/data/models/explore_models.dart';

class ExploreRemoteDataSource {
  final ApiClient _client;

  ExploreRemoteDataSource(this._client);

  Future<NearbyWorkersResponse> getNearbyWorkers({
    required double latitude,
    required double longitude,
    List<String>? serviceIds,
    int limit = 20,
  }) async {
    final buffer = StringBuffer()
      ..write(
          '/customers/me/nearby-workers?latitude=$latitude&longitude=$longitude&limit=$limit');
    if (serviceIds != null && serviceIds.isNotEmpty) {
      buffer.write('&serviceIds=${serviceIds.join(',')}');
    }
    final data = await _client.get(buffer.toString());
    return NearbyWorkersResponse.fromJson(data);
  }
}
