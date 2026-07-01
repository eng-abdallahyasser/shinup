import 'package:shineup/features/profile/data/models/address_models.dart';
import 'package:shineup/features/profile/data/models/car_models.dart';
import 'package:shineup/features/profile/data/models/profile_model.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfile();
  Future<void> logout();
  Future<List<CarTypeModel>> getCarTypes();
  Future<void> addCar(AddCarRequest request);
  Future<List<UserCarModel>> getCars();
  Future<UserCarModel> getCar(String carId);
  Future<UserCarModel> updateCar(String carId, UpdateCarRequest request);
  Future<void> setDefaultCar(String carId);
  Future<void> deleteCar(String carId);
  Future<ProfileModel> uploadAvatar(String filePath);
  Future<List<AddressModel>> getAddresses();
  Future<AddressModel> getAddress(String addressId);
  Future<void> addAddress(AddAddressRequest request);
  Future<AddressModel> updateAddress(
      String addressId, UpdateAddressRequest request);
  Future<void> setDefaultAddress(String addressId);
  Future<void> deleteAddress(String addressId);
}
