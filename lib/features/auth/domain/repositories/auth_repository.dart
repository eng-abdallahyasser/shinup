import 'package:shineup/features/auth/data/models/auth_models.dart';

abstract class AuthRepository {
  Future<AuthResponse> register({
    required String fullName,
    required String phone,
    required String email,
    required String password,
    String accountType = 'customer',
  });

  Future<AuthResponse> login({
    required String identifier,
    required String password,
    String deviceType = 'ANDROID',
    String deviceToken = '',
  });

  Future<AuthResponse> verifyOtp({
    required String userId,
    required String code,
  });

  Future<AuthResponse> forgotPassword({required String identifier});

  Future<AuthResponse> resetPassword({
    required String identifier,
    required String code,
    required String newPassword,
  });

  Future<AuthResponse> getProfile();

  Future<void> logout();

  Future<void> saveToken(String token);
  String? getToken();
  Future<void> clearToken();
  Future<void> saveUserData(Map<String, dynamic> userData);
  Map<String, dynamic>? getUserData();
}
