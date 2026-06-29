import 'package:shinup/features/provider/data/datasources/provider_remote_datasource.dart';
import 'package:shinup/features/provider/data/models/nearby_worker_model.dart';
import 'package:shinup/features/provider/domain/repositories/provider_repository.dart';

class ProviderRepositoryImpl implements ProviderRepository {
  final ProviderRemoteDataSource _remoteDataSource;

  ProviderRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<NearbyWorkerResult>> getNearbyWorkers({
    required double latitude,
    required double longitude,
    required List<String> serviceIds,
    int limit = 10,
  }) async {
    return _remoteDataSource.getNearbyWorkers(
      latitude: latitude,
      longitude: longitude,
      serviceIds: serviceIds,
      limit: limit,
    );
  }
}
