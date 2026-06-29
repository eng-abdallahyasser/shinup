import 'package:shinup/core/network/api_client.dart';
import 'package:shinup/features/explore/data/models/explore_models.dart';

class ExploreRemoteDataSource {
  final ApiClient _client;

  ExploreRemoteDataSource(this._client);

  Future<List<NearbyProvider>> getNearbyProviders(double lat, double lng) async {
    final data = await _client.getList(
      '/providers/nearby?lat=$lat&lng=$lng',
    );
    return data
        .map((e) => NearbyProvider.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
