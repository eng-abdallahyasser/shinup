import 'package:flutter/material.dart';
import 'package:shinup/core/network/api_client.dart';
import 'package:shinup/features/home/data/models/home_models.dart';

class HomeRemoteDataSource {
  final ApiClient _client;

  HomeRemoteDataSource(this._client);

  Future<List<ProviderData>> getRecommendedProviders() async {
    final data = await _client.getList('/providers/recommended');
    return data.map((e) {
      final json = e as Map<String, dynamic>;
      return ProviderData(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        rating: json['rating'] as String? ?? '0.0',
        distanceValue: (json['distance'] as num?)?.toDouble() ?? 0.0,
        tags: (json['tags'] as List<dynamic>?)
                ?.map((t) => t as String)
                .toList() ??
            [],
        status: json['status'] as String? ?? '',
        statusColor: _parseColor(json['statusColor'] as String?),
        statusTextColor: _parseColor(json['statusTextColor'] as String?),
        imagePath: json['imagePath'] as String? ?? '',
      );
    }).toList();
  }

  Future<List<PromoData>> getPromos() async {
    final data = await _client.getList('/promos');
    return data.map((e) {
      final json = e as Map<String, dynamic>;
      return PromoData(
        label: json['label'] as String? ?? '',
        title: json['title'] as String? ?? '',
        backgroundColor: _parseColor(json['backgroundColor'] as String?),
        labelColor: _parseColor(json['labelColor'] as String?),
        titleColor: _parseColor(json['titleColor'] as String?),
        iconColor: _parseColor(json['iconColor'] as String?),
        icon:
            _parseIcon(json['icon'] as String?) ?? Icons.local_offer_outlined,
      );
    }).toList();
  }

  Future<List<ServiceCategory>> getServiceCategories() async {
    final data = await _client.getList('/catalog/service-categories');
    return data
        .map((e) => ServiceCategory.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Service>> getServicesByCategory(String categoryId) async {
    final data = await _client.getList(
      '/catalog/services?categoryId=$categoryId',
    );
    return data
        .map((e) => Service.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Color _parseColor(String? hex) {
    if (hex == null) return const Color(0xFFE3F2FD);
    final color = int.tryParse(hex.replaceFirst('#', ''), radix: 16);
    if (color == null) return const Color(0xFFE3F2FD);
    return Color(color);
  }

  IconData? _parseIcon(String? name) {
    if (name == null) return null;
    switch (name) {
      case 'local_car_wash_outlined':
        return Icons.local_car_wash_outlined;
      case 'build_outlined':
        return Icons.build_outlined;
      case 'settings_outlined':
        return Icons.settings_outlined;
      case 'local_offer_outlined':
        return Icons.local_offer_outlined;
      case 'headset_mic_outlined':
        return Icons.headset_mic_outlined;
      default:
        return null;
    }
  }
}
