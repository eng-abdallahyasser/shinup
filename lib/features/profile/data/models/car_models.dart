class CarTypeModel {
  final String id;
  final String name;
  final String description;
  final bool activeIs;

  const CarTypeModel({
    required this.id,
    required this.name,
    required this.description,
    this.activeIs = true,
  });

  factory CarTypeModel.fromJson(Map<String, dynamic> json) {
    return CarTypeModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      activeIs: json['activeIs'] as bool? ?? true,
    );
  }
}

class UserCarModel {
  final String id;
  final String userId;
  final String carTypeId;
  final String brand;
  final String model;
  final int year;
  final String color;
  final String plateNumber;
  final bool defaultIs;
  final String atCreated;
  final String atUpdated;
  final CarTypeModel carType;

  const UserCarModel({
    required this.id,
    required this.userId,
    required this.carTypeId,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.plateNumber,
    this.defaultIs = false,
    this.atCreated = '',
    this.atUpdated = '',
    required this.carType,
  });

  factory UserCarModel.fromJson(Map<String, dynamic> json) {
    return UserCarModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      carTypeId: json['carTypeId'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      model: json['model'] as String? ?? '',
      year: json['year'] as int? ?? 0,
      color: json['color'] as String? ?? '',
      plateNumber: json['plateNumber'] as String? ?? '',
      defaultIs: json['defaultIs'] as bool? ?? false,
      atCreated: json['atCreated'] as String? ?? '',
      atUpdated: json['atUpdated'] as String? ?? '',
      carType: json['carType'] != null
          ? CarTypeModel.fromJson(json['carType'] as Map<String, dynamic>)
          : CarTypeModel(id: '', name: '', description: ''),
    );
  }

  UserCarModel copyWith({
    String? brand,
    String? model,
    int? year,
    String? color,
    String? plateNumber,
    bool? defaultIs,
  }) {
    return UserCarModel(
      id: id,
      userId: userId,
      carTypeId: carTypeId,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      color: color ?? this.color,
      plateNumber: plateNumber ?? this.plateNumber,
      defaultIs: defaultIs ?? this.defaultIs,
      atCreated: atCreated,
      atUpdated: atUpdated,
      carType: carType,
    );
  }

  /// Display name combining brand and model, e.g. "Toyota Corolla"
  String get displayName => '$brand $model';
}

class AddCarRequest {
  final String carTypeId;
  final String brand;
  final String model;
  final int year;
  final String color;
  final String plateNumber;
  final bool defaultIs;

  const AddCarRequest({
    required this.carTypeId,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.plateNumber,
    this.defaultIs = true,
  });

  Map<String, dynamic> toJson() => {
        'carTypeId': carTypeId,
        'brand': brand,
        'model': model,
        'year': year,
        'color': color,
        'plateNumber': plateNumber,
        'defaultIs': defaultIs,
      };
}

class UpdateCarRequest {
  final String brand;
  final String model;
  final int year;
  final String color;
  final String plateNumber;

  const UpdateCarRequest({
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.plateNumber,
  });

  Map<String, dynamic> toJson() => {
        'brand': brand,
        'model': model,
        'year': year,
        'color': color,
        'plateNumber': plateNumber,
      };
}
