import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinup/core/network/api_client.dart';
import 'package:shinup/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:shinup/features/profile/data/models/car_models.dart';
import 'package:shinup/features/profile/data/models/profile_model.dart';
import 'package:shinup/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final ApiClient _apiClient;
  final SharedPreferences _prefs;

  ProfileRepositoryImpl(
    this._remoteDataSource,
    this._apiClient,
    this._prefs,
  );

  @override
  Future<ProfileModel> getProfile() async {
    return _remoteDataSource.getProfile();
  }

  @override
  Future<void> logout() async {
    try {
      await _remoteDataSource.logout();
    } catch (_) {
      // Proceed even if logout API fails
    }
    await _prefs.remove('auth_token');
    await _prefs.remove('user_data');
    _apiClient.setToken(null);
  }

  @override
  Future<List<CarTypeModel>> getCarTypes() async {
    return _remoteDataSource.getCarTypes();
  }

  @override
  Future<void> addCar(AddCarRequest request) async {
    await _remoteDataSource.addCar(request);
  }

  @override
  Future<List<UserCarModel>> getCars() async {
    return _remoteDataSource.getCars();
  }

  @override
  Future<UserCarModel> getCar(String carId) async {
    return _remoteDataSource.getCar(carId);
  }

  @override
  Future<UserCarModel> updateCar(String carId, UpdateCarRequest request) async {
    return _remoteDataSource.updateCar(carId, request);
  }

  @override
  Future<void> setDefaultCar(String carId) async {
    await _remoteDataSource.setDefaultCar(carId);
  }
}
