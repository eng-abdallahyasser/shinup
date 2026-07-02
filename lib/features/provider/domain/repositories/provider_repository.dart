import 'package:shineup/features/provider/data/models/nearby_worker_model.dart';
import 'package:shineup/features/provider/data/models/provider_detail_model.dart';

abstract class ProviderRepository {
  Future<List<NearbyWorkerResult>> getNearbyWorkers({
    required double latitude,
    required double longitude,
    required List<String> serviceIds,
    int limit = 10,
  });

  Future<ProviderDetailModel> getProviderDetail(String providerId);
}
