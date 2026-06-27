import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shinup/core/network/api_client.dart';
import 'package:shinup/features/profile/data/models/address_models.dart';
import 'package:shinup/features/profile/data/models/car_models.dart';
import 'package:shinup/features/profile/data/models/profile_model.dart';
import 'package:shinup/features/profile/domain/repositories/profile_repository.dart';

// ── Active session model ───────────────────────────────────────────────

class ActiveSession extends Equatable {
  final String device;
  final String browser;
  final String location;
  final bool isCurrent;
  final String? timeAgo;

  const ActiveSession({
    required this.device,
    required this.browser,
    required this.location,
    this.isCurrent = false,
    this.timeAgo,
  });

  @override
  List<Object?> get props => [device, browser, location, isCurrent, timeAgo];
}

// ── Loyalty activity model ────────────────────────────────────────────

class LoyaltyActivity extends Equatable {
  final String label;
  final int points;
  final bool isPositive;

  const LoyaltyActivity({
    required this.label,
    required this.points,
    this.isPositive = true,
  });

  @override
  List<Object?> get props => [label, points, isPositive];
}

// ── State ───────────────────────────────────────────────────────────────────

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final String? errorMessage;

  // User info
  final String fullName;
  final String email;
  final String phone;
  final String? avatarUrl;
  final bool isEditing;

  // Password fields
  final bool showOldPassword;
  final bool showNewPassword;

  // Loyalty
  final int points;
  final String pointsLabel;
  final int pointsProgress;
  final List<LoyaltyActivity> recentActivities;

  // Vehicles
  final List<UserCarModel> vehicles;

  // Addresses
  final List<AddressModel> addresses;

  // Sessions
  final List<ActiveSession> sessions;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.errorMessage,
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.avatarUrl,
    this.isEditing = false,
    this.showOldPassword = false,
    this.showNewPassword = false,
    this.points = 0,
    this.pointsLabel = 'Rewards Points',
    this.pointsProgress = 0,
    this.recentActivities = const [],
    this.vehicles = const [],
    this.addresses = const [],
    this.sessions = const [],
  });

  ProfileState copyWith({
    ProfileStatus? status,
    String? errorMessage,
    String? fullName,
    String? email,
    String? phone,
    String? avatarUrl,
    bool? isEditing,
    bool? showOldPassword,
    bool? showNewPassword,
    int? points,
    String? pointsLabel,
    int? pointsProgress,
    List<LoyaltyActivity>? recentActivities,
    List<UserCarModel>? vehicles,
    List<AddressModel>? addresses,
    List<ActiveSession>? sessions,
  }) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isEditing: isEditing ?? this.isEditing,
      showOldPassword: showOldPassword ?? this.showOldPassword,
      showNewPassword: showNewPassword ?? this.showNewPassword,
      points: points ?? this.points,
      pointsLabel: pointsLabel ?? this.pointsLabel,
      pointsProgress: pointsProgress ?? this.pointsProgress,
      recentActivities: recentActivities ?? this.recentActivities,
      vehicles: vehicles ?? this.vehicles,
      addresses: addresses ?? this.addresses,
      sessions: sessions ?? this.sessions,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        fullName,
        email,
        phone,
        avatarUrl,
        isEditing,
        showOldPassword,
        showNewPassword,
        points,
        pointsLabel,
        pointsProgress,
        recentActivities,
        vehicles,
        addresses,
        sessions,
      ];
}

// ── Cubit ───────────────────────────────────────────────────────────────────

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));

    try {
      final results = await Future.wait([
        _profileRepository.getProfile(),
        _profileRepository.getCars(),
        _profileRepository.getAddresses(),
      ]);
      final profile = results[0] as ProfileModel;
      final cars = results[1] as List<UserCarModel>;
      final addresses = results[2] as List<AddressModel>;
      emit(state.copyWith(
        status: ProfileStatus.loaded,
        fullName: profile.fullName,
        email: profile.email,
        phone: profile.phone,
        avatarUrl: profile.avatarUrl,
        vehicles: cars,
        addresses: addresses,
      ));
    } on ApiException catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'Failed to load profile. Please try again.',
      ));
    }
  }

  Future<void> logout() async {
    await _profileRepository.logout();
  }

  Future<void> deleteCar(String carId) async {
    try {
      await _profileRepository.deleteCar(carId);
      final updatedVehicles =
          state.vehicles.where((v) => v.id != carId).toList();
      emit(state.copyWith(vehicles: updatedVehicles));
    } on ApiException catch (e) {
      emit(state.copyWith(errorMessage: e.message));
    } catch (_) {
      emit(state.copyWith(
        errorMessage: 'Failed to delete vehicle. Please try again.',
      ));
    }
  }

  Future<void> deleteAddress(String addressId) async {
    try {
      await _profileRepository.deleteAddress(addressId);
      final updated = state.addresses.where((a) => a.id != addressId).toList();
      emit(state.copyWith(addresses: updated));
    } on ApiException catch (e) {
      emit(state.copyWith(errorMessage: e.message));
    } catch (_) {
      emit(state.copyWith(
        errorMessage: 'Failed to delete address. Please try again.',
      ));
    }
  }

  Future<void> uploadAvatar() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));
    try {
      final profile = await _profileRepository.uploadAvatar(picked.path);
      emit(state.copyWith(
        status: ProfileStatus.loaded,
        avatarUrl: profile.avatarUrl,
      ));
    } on ApiException catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.loaded,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: ProfileStatus.loaded,
        errorMessage: 'Failed to upload image. Please try again.',
      ));
    }
  }

  void onToggleEditMode() => emit(state.copyWith(isEditing: !state.isEditing));

  void onUpdateFullName(String name) =>
      emit(state.copyWith(fullName: name));

  void onUpdateEmail(String email) =>
      emit(state.copyWith(email: email));

  void onUpdatePhone(String phone) =>
      emit(state.copyWith(phone: phone));

  void onSaveProfile() =>
      emit(state.copyWith(isEditing: false));

  void onToggleOldPasswordVisibility() =>
      emit(state.copyWith(showOldPassword: !state.showOldPassword));

  void onToggleNewPasswordVisibility() =>
      emit(state.copyWith(showNewPassword: !state.showNewPassword));
}
