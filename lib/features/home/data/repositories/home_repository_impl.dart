import 'package:shineup/features/home/data/datasources/home_remote_datasource.dart';
import 'package:shineup/features/home/data/models/home_models.dart';
import 'package:shineup/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<ProviderData>> getRecommendedProviders() async {
    return _remoteDataSource.getRecommendedProviders();
  }

  @override
  Future<List<PromoData>> getPromos() async {
    return _remoteDataSource.getPromos();
  }

  @override
  Future<List<ServiceCategory>> getServiceCategories() async {
    return _remoteDataSource.getServiceCategories();
  }

  @override
  Future<List<Service>> getServicesByCategory(String categoryId) async {
    return _remoteDataSource.getServicesByCategory(categoryId);
  }
}
