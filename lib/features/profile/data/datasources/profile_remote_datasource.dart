import 'package:shineup/core/network/api_client.dart';
import 'package:shineup/features/profile/data/models/address_models.dart';
import 'package:shineup/features/profile/data/models/car_models.dart';
import 'package:shineup/features/profile/data/models/profile_model.dart';

class ProfileRemoteDataSource {
  final ApiClient _client;

  ProfileRemoteDataSource(this._client);

  Future<ProfileModel> getProfile() async {
    final data = await _client.get('/auth/profile');
    return ProfileModel.fromJson(data);
  }

  Future<void> logout() async {
    await _client.post('/auth/logout');
  }

  Future<List<CarTypeModel>> getCarTypes() async {
    final data = await _client.getList('/catalog/car-types');
    return data
        .map((e) => CarTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> addCar(AddCarRequest request) async {
    await _client.post('/customers/me/cars', body: request.toJson());
  }

  Future<List<UserCarModel>> getCars() async {
    final data = await _client.getList('/customers/me/cars');
    return data
        .map((e) => UserCarModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<UserCarModel> getCar(String carId) async {
    final data = await _client.get('/customers/me/cars/$carId');
    return UserCarModel.fromJson(data);
  }

  Future<UserCarModel> updateCar(String carId, UpdateCarRequest request) async {
    final data = await _client.patch(
      '/customers/me/cars/$carId',
      body: request.toJson(),
    );
    return UserCarModel.fromJson(data);
  }

  Future<void> setDefaultCar(String carId) async {
    await _client.patch('/customers/me/cars/$carId/default');
  }

  Future<void> deleteCar(String carId) async {
    await _client.delete('/customers/me/cars/$carId');
  }

  Future<ProfileModel> uploadAvatar(String filePath) async {
    final data = await _client.uploadFile(
      '/auth/profile/avatar',
      filePath: filePath,
      fieldName: 'avatar',
      method: 'PATCH',
    );
    return ProfileModel.fromJson(data);
  }

  Future<List<AddressModel>> getAddresses() async {
    final data = await _client.getList('/customers/me/addresses');
    return data
        .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<AddressModel> getAddress(String addressId) async {
    final data = await _client.get('/customers/me/addresses/$addressId');
    return AddressModel.fromJson(data);
  }

  Future<void> addAddress(AddAddressRequest request) async {
    await _client.post('/customers/me/addresses', body: request.toJson());
  }

  Future<AddressModel> updateAddress(
      String addressId, UpdateAddressRequest request) async {
    final data = await _client.patch(
      '/customers/me/addresses/$addressId',
      body: request.toJson(),
    );
    return AddressModel.fromJson(data);
  }

  Future<void> setDefaultAddress(String addressId) async {
    await _client.patch('/customers/me/addresses/$addressId/default');
  }

  Future<void> deleteAddress(String addressId) async {
    await _client.delete('/customers/me/addresses/$addressId');
  }
}
