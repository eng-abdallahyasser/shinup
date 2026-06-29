import 'package:shinup/features/explore/data/models/explore_models.dart';

abstract class ExploreRepository {
  Future<List<NearbyProvider>> getNearbyProviders(double lat, double lng);
}
