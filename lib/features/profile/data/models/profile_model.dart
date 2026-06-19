class ProfileModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final bool isActive;
  final List<RoleModel> roles;

  const ProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.isActive = true,
    this.roles = const [],
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      roles: (json['roles'] as List<dynamic>?)
              ?.map((r) => RoleModel.fromJson(r as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class RoleModel {
  final String name;
  final String? scopeType;
  final String? scopeId;

  const RoleModel({
    required this.name,
    this.scopeType,
    this.scopeId,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      name: json['name'] as String? ?? '',
      scopeType: json['scopeType'] as String?,
      scopeId: json['scopeId'] as String?,
    );
  }
}
