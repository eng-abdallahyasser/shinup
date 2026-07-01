import 'package:shineup/features/explore/data/datasources/explore_remote_datasource.dart';
import 'package:shineup/features/explore/data/models/explore_models.dart';
import 'package:shineup/features/explore/domain/repositories/explore_repository.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreRemoteDataSource _remoteDataSource;

  ExploreRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<NearbyProvider>> getNearbyProviders(double lat, double lng) async {
    return _remoteDataSource.getNearbyProviders(lat, lng);
  }
}
