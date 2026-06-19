class RegisterRequest {
  final String fullName;
  final String phone;
  final String email;
  final String password;
  final String accountType;

  RegisterRequest({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.password,
    this.accountType = 'customer',
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'phone': phone,
        'email': email,
        'password': password,
        'accountType': accountType,
      };
}

class LoginRequest {
  final String? phone;
  final String? email;
  final String password;
  final String deviceType;

  LoginRequest({
    this.phone,
    this.email,
    required this.password,
    this.deviceType = 'ANDROID',
  });

  Map<String, dynamic> toJson() => {
        if (phone != null) 'phone': phone,
        if (email != null) 'email': email,
        'password': password,
        'deviceType': deviceType,
      };
}

class OtpVerifyRequest {
  final String userId;
  final String purpose;
  final String code;

  OtpVerifyRequest({
    required this.userId,
    this.purpose = 'PHONE_VERIFICATION',
    required this.code,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'purpose': purpose,
        'code': code,
      };
}

class ForgotPasswordRequest {
  final String identifier;

  ForgotPasswordRequest({required this.identifier});

  Map<String, dynamic> toJson() => {'identifier': identifier};
}

class ResetPasswordRequest {
  final String identifier;
  final String code;
  final String newPassword;

  ResetPasswordRequest({
    required this.identifier,
    required this.code,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
        'identifier': identifier,
        'code': code,
        'newPassword': newPassword,
      };
}

class AuthResponse {
  final String? token;
  final String? userId;
  final String? message;
  final Map<String, dynamic>? user;

  AuthResponse({
    this.token,
    this.userId,
    this.message,
    this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['accessToken'] as String?,
      userId: json['userId'] as String? ?? json['user']?['id'] as String?,
      message: json['message'] as String?,
      user: json['user'] as Map<String, dynamic>?,
    );
  }
}
