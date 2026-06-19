import 'package:shinup/features/profile/data/models/car_models.dart';
import 'package:shinup/features/profile/data/models/profile_model.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfile();
  Future<void> logout();
  Future<List<CarTypeModel>> getCarTypes();
  Future<void> addCar(AddCarRequest request);
  Future<List<UserCarModel>> getCars();
  Future<UserCarModel> getCar(String carId);
  Future<UserCarModel> updateCar(String carId, UpdateCarRequest request);
  Future<void> setDefaultCar(String carId);
}
