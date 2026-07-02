import 'package:flutter/material.dart';
import 'package:shineup/core/di/service_locator.dart';
import 'package:shineup/core/localization/app_localizations.dart';
import 'package:shineup/core/routes/app_pages.dart';
import 'package:shineup/features/booking/data/models/booking_flow_data.dart';
import 'package:shineup/features/provider/data/models/provider_detail_model.dart';
import 'package:shineup/features/provider/domain/repositories/provider_repository.dart';
import 'package:shineup/features/provider/presentation/widgets/bottom_cta.dart';
import 'package:shineup/features/provider/presentation/widgets/hero_image.dart';
import 'package:shineup/features/provider/presentation/widgets/primary_actions.dart';
import 'package:shineup/features/provider/presentation/widgets/profile_header.dart';
import 'package:shineup/features/provider/presentation/widgets/reviews_content.dart';
import 'package:shineup/features/provider/presentation/widgets/about_content.dart';
import 'package:shineup/features/provider/presentation/widgets/services_content.dart';

// TODO: Replace with dynamic image URL from API response
const _providerImages = {
  'shine-co': 'assets/images/provider_shine_co.jpg',
  'garage-37': 'assets/images/provider_garage_37.jpg',
};

class ProviderDetailPage extends StatefulWidget {
  final String providerId;

  const ProviderDetailPage({super.key, required this.providerId});

  @override
  State<ProviderDetailPage> createState() => _ProviderDetailPageState();
}

class _ProviderDetailPageState extends State<ProviderDetailPage> {
  final ProviderRepository _repository = sl<ProviderRepository>();

  int _selectedTab = 0;
  ProviderDetailModel? _provider;
  bool _isLoading = true;
  String? _error;
  final Set<String> _selectedServiceIds = {};

  @override
  void initState() {
    super.initState();
    _loadProvider();
  }

  Future<void> _loadProvider() async {
    try {
      final provider = await _repository.getProviderDetail(widget.providerId);
      if (mounted) {
        setState(() {
          _provider = provider;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _toggleService(String id) {
    setState(() {
      if (_selectedServiceIds.contains(id)) {
        _selectedServiceIds.remove(id);
      } else {
        _selectedServiceIds.add(id);
      }
    });
  }

  double get _totalCost {
    if (_provider == null) return 0;
    double total = 0;
    for (final summary in _provider!.servicesSummary) {
      if (_selectedServiceIds.contains(summary.id)) {
        total += summary.priceSummary.priceProvider;
      }
    }
    return total;
  }

  int get _totalDurationMinutes {
    if (_provider == null) return 0;
    int total = 0;
    for (final summary in _provider!.servicesSummary) {
      if (_selectedServiceIds.contains(summary.id)) {
        total += summary.priceSummary.durationMinutes;
      }
    }
    return total;
  }

  List<SelectedService> get _selectedServices {
    if (_provider == null) return [];
    return _provider!.servicesSummary
        .where((s) => _selectedServiceIds.contains(s.id))
        .map((s) => SelectedService(
              providerServiceId: s.id,
              name: s.displayName,
              price: s.priceSummary.priceProvider,
              durationMinutes: s.priceSummary.durationMinutes,
            ))
        .toList();
  }

  List<ServiceCategoryGroup> _buildServiceGroups() {
    if (_provider == null) return [];

    final Map<String, List<ServiceData>> grouped = {};
    for (final summary in _provider!.servicesSummary) {
      final categoryName = summary.service.category.name;
      grouped.putIfAbsent(categoryName, () => []);
      grouped[categoryName]!.add(
        ServiceData(
          id: summary.id,
          name: summary.displayName,
          description: summary.description,
          price: '\$${summary.priceSummary.priceProvider.toStringAsFixed(0)}',
          duration: '${summary.priceSummary.durationMinutes} min',
        ),
      );
    }

    return grouped.entries.map((entry) {
      return ServiceCategoryGroup(
        categoryName: entry.key,
        services: entry.value,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text('$_error'))
                : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 96),
          child: Column(
            children: [
              HeroImage(
                imagePath: _providerImages[widget.providerId] ??
                    'assets/images/provider_shine_co.jpg',
              ),
              ProfileHeader(
                nameBusiness: _provider!.nameBusiness,
                availableIs: _provider!.availableIs,
                description: _provider!.description,
              ),
              const PrimaryActions(),
              _buildTabBar(),
              _buildTabContent(),
            ],
          ),
        ),

        BottomCta(
          totalCost: _totalCost,
          itemCount: _selectedServiceIds.length,
          onBookNow: () {
            final flowData = BookingFlowData(
              providerId: _provider!.id,
              providerMemberId: _provider!.providerMemberId ?? _provider!.id,
              providerName: _provider!.nameBusiness,
              selectedServices: _selectedServices,
              totalCost: _totalCost,
              totalDurationMinutes: _totalDurationMinutes,
            );
            Navigator.of(context).pushNamed(
              AppRouter.bookingStep2,
              arguments: flowData,
            );
          },
        ),
      ],
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return ServicesContent(
          groups: _buildServiceGroups(),
          selectedIds: _selectedServiceIds,
          onToggle: _toggleService,
        );
      case 1:
        return const ReviewsContent();
      case 2:
        return AboutContent(description: _provider?.description ?? '');
      default:
        return ServicesContent(
          groups: _buildServiceGroups(),
          selectedIds: _selectedServiceIds,
          onToggle: _toggleService,
        );
    }
  }

  Widget _buildTabBar() {
    final t = AppLocalizations.of(context);
    final tabs = [
      t.providerTabServices,
      t.providerTabReviews,
      t.providerTabAbout
    ];
    return Container(
      height: 51,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFFAF8FF),
        border: Border(
          bottom: BorderSide(color: Color(0xFFC3C6D7)),
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isActive = _selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: isActive
                      ? const Border(
                          bottom: BorderSide(
                            color: Color(0xFF004AC6),
                            width: 2,
                          ),
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 24 / 16,
                      color: isActive
                          ? const Color(0xFF004AC6)
                          : const Color(0xFF434655),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
