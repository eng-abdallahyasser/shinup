import 'package:flutter/material.dart';

class ProviderData {
  final String id;
  final String name;
  final String rating;
  final double distanceValue;
  final List<String> tags;
  final String status;
  final Color statusColor;
  final Color statusTextColor;
  final String imagePath;

  const ProviderData({
    required this.id,
    required this.name,
    required this.rating,
    required this.distanceValue,
    required this.tags,
    required this.status,
    required this.statusColor,
    required this.statusTextColor,
    required this.imagePath,
  });
}

class PromoData {
  final String label;
  final String title;
  final Color backgroundColor;
  final Color labelColor;
  final Color titleColor;
  final Color iconColor;
  final IconData icon;

  const PromoData({
    required this.label,
    required this.title,
    required this.backgroundColor,
    required this.labelColor,
    required this.titleColor,
    required this.iconColor,
    required this.icon,
  });
}

class ServiceCategory {
  final String id;
  final String name;
  final String description;
  final String? image;
  final int orderSort;
  final bool activeIs;

  const ServiceCategory({
    required this.id,
    required this.name,
    required this.description,
    this.image,
    required this.orderSort,
    required this.activeIs,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: json['image'] as String?,
      orderSort: (json['orderSort'] as num?)?.toInt() ?? 0,
      activeIs: json['activeIs'] as bool? ?? false,
    );
  }
}

class Service {
  final String id;
  final String categoryId;
  final String name;
  final String type;
  final String description;
  final String? image;
  final bool activeIs;

  const Service({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.type,
    required this.description,
    this.image,
    required this.activeIs,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: json['image'] as String?,
      activeIs: json['activeIs'] as bool? ?? false,
    );
  }
}
