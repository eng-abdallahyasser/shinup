import 'package:shineup/features/provider/data/models/nearby_worker_model.dart';

abstract class ProviderRepository {
  Future<List<NearbyWorkerResult>> getNearbyWorkers({
    required double latitude,
    required double longitude,
    required List<String> serviceIds,
    int limit = 10,
  });
}
