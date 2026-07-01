import 'package:shineup/features/explore/data/models/explore_models.dart';

abstract class ExploreRepository {
  Future<NearbyWorkersResponse> getNearbyWorkers({
    required double latitude,
    required double longitude,
    List<String>? serviceIds,
    int limit = 20,
  });
}
