import 'package:shinup/core/network/api_client.dart';
import 'package:shinup/features/auth/data/models/auth_models.dart';

class AuthRemoteDataSource {
  final ApiClient _client;

  AuthRemoteDataSource(this._client);

  Future<AuthResponse> register(RegisterRequest request) async {
    final data = await _client.post('/auth/register', body: request.toJson());
    return AuthResponse.fromJson(data);
  }

  Future<AuthResponse> login(LoginRequest request) async {
    final data = await _client.post('/auth/login', body: request.toJson());
    return AuthResponse.fromJson(data);
  }

  Future<AuthResponse> verifyOtp(OtpVerifyRequest request) async {
    final data = await _client.post('/auth/otp/verify', body: request.toJson());
    return AuthResponse.fromJson(data);
  }

  Future<AuthResponse> forgotPassword(ForgotPasswordRequest request) async {
    final data =
        await _client.post('/auth/password/forgot', body: request.toJson());
    return AuthResponse.fromJson(data);
  }

  Future<AuthResponse> resetPassword(ResetPasswordRequest request) async {
    final data =
        await _client.post('/auth/password/reset', body: request.toJson());
    return AuthResponse.fromJson(data);
  }

  Future<AuthResponse> getProfile() async {
    final data = await _client.get('/auth/profile');
    return AuthResponse.fromJson(data);
  }

  Future<void> logout() async {
    await _client.post('/auth/logout');
  }
}
