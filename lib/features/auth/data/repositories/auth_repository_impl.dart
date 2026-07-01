import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shineup/core/network/api_client.dart';
import 'package:shineup/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:shineup/features/auth/data/models/auth_models.dart';
import 'package:shineup/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final ApiClient _apiClient;
  final SharedPreferences _prefs;

  AuthRepositoryImpl(this._remoteDataSource, this._apiClient, this._prefs) {
    // Restore token on creation
    final savedToken = _prefs.getString('auth_token');
    if (savedToken != null && savedToken.isNotEmpty) {
      _apiClient.setToken(savedToken);
    }
  }

  @override
  Future<AuthResponse> register({
    required String fullName,
    required String phone,
    required String email,
    required String password,
    String accountType = 'customer',
  }) async {
    final request = RegisterRequest(
      fullName: fullName,
      phone: phone,
      email: email,
      password: password,
      accountType: accountType,
    );
    return _remoteDataSource.register(request);
  }

  @override
  Future<AuthResponse> login({
    required String identifier,
    required String password,
    String deviceType = 'ANDROID',
    String deviceToken = '',
  }) async {
    final request = LoginRequest(
      identifier: identifier,
      password: password,
      deviceType: deviceType,
      deviceToken: deviceToken,
    );
    final response = await _remoteDataSource.login(request);
    return response;
  }

  @override
  Future<AuthResponse> verifyOtp({
    required String userId,
    required String code,
  }) async {
    final request = OtpVerifyRequest(userId: userId, code: code);
    return _remoteDataSource.verifyOtp(request);
  }

  @override
  Future<AuthResponse> forgotPassword({required String identifier}) async {
    final request = ForgotPasswordRequest(identifier: identifier);
    return _remoteDataSource.forgotPassword(request);
  }

  @override
  Future<AuthResponse> resetPassword({
    required String identifier,
    required String code,
    required String newPassword,
  }) async {
    final request = ResetPasswordRequest(
      identifier: identifier,
      code: code,
      newPassword: newPassword,
    );
    return _remoteDataSource.resetPassword(request);
  }

  @override
  Future<AuthResponse> getProfile() async {
    return _remoteDataSource.getProfile();
  }

  @override
  Future<void> logout() async {
    try {
      await _remoteDataSource.logout();
    } catch (_) {
      // Proceed even if logout API fails
    }
    await clearToken();
  }

  @override
  Future<void> saveToken(String token) async {
    await _prefs.setString('auth_token', token);
    _apiClient.setToken(token);
  }

  @override
  String? getToken() {
    return _prefs.getString('auth_token');
  }

  @override
  Future<void> clearToken() async {
    await _prefs.remove('auth_token');
    await _prefs.remove('user_data');
    _apiClient.setToken(null);
  }

  @override
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final jsonStr = jsonEncode(userData);
    await _prefs.setString('user_data', jsonStr);
  }

  @override
  Map<String, dynamic>? getUserData() {
    final data = _prefs.getString('user_data');
    if (data == null || data.isEmpty) return null;
    try {
      return jsonDecode(data) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }
}
