import 'package:shineup/features/explore/data/datasources/explore_remote_datasource.dart';
import 'package:shineup/features/explore/data/models/explore_models.dart';
import 'package:shineup/features/explore/domain/repositories/explore_repository.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreRemoteDataSource _remoteDataSource;

  ExploreRepositoryImpl(this._remoteDataSource);

  @override
  Future<NearbyWorkersResponse> getNearbyWorkers({
    required double latitude,
    required double longitude,
    List<String>? serviceIds,
    int limit = 20,
  }) {
    return _remoteDataSource.getNearbyWorkers(
      latitude: latitude,
      longitude: longitude,
      serviceIds: serviceIds,
      limit: limit,
    );
  }
}
