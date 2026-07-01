import 'package:shineup/features/home/data/models/home_models.dart';

abstract class HomeRepository {
  Future<List<ProviderData>> getRecommendedProviders();
  Future<List<PromoData>> getPromos();
  Future<List<ServiceCategory>> getServiceCategories();
  Future<List<Service>> getServicesByCategory(String categoryId);
}
