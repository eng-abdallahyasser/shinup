import 'package:shared_preferences/shared_preferences.dart';
import 'package:shineup/core/network/api_client.dart';
import 'package:shineup/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:shineup/features/profile/data/models/address_models.dart';
import 'package:shineup/features/profile/data/models/car_models.dart';
import 'package:shineup/features/profile/data/models/profile_model.dart';
import 'package:shineup/features/profile/domain/repositories/profile_repository.dart';

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

  @override
  Future<void> deleteCar(String carId) async {
    await _remoteDataSource.deleteCar(carId);
  }

  @override
  Future<ProfileModel> uploadAvatar(String filePath) async {
    return _remoteDataSource.uploadAvatar(filePath);
  }

  @override
  Future<List<AddressModel>> getAddresses() async {
    return _remoteDataSource.getAddresses();
  }

  @override
  Future<AddressModel> getAddress(String addressId) async {
    return _remoteDataSource.getAddress(addressId);
  }

  @override
  Future<void> addAddress(AddAddressRequest request) async {
    await _remoteDataSource.addAddress(request);
  }

  @override
  Future<AddressModel> updateAddress(
      String addressId, UpdateAddressRequest request) async {
    return _remoteDataSource.updateAddress(addressId, request);
  }

  @override
  Future<void> setDefaultAddress(String addressId) async {
    await _remoteDataSource.setDefaultAddress(addressId);
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    await _remoteDataSource.deleteAddress(addressId);
  }
}
