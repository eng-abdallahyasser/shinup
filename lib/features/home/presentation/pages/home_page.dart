import 'package:flutter/material.dart';
import 'package:shinup/core/di/service_locator.dart';
import 'package:shinup/core/localization/app_localizations.dart';
import 'package:shinup/core/routes/app_pages.dart';
import 'package:shinup/features/home/data/models/home_models.dart';
import 'package:shinup/features/home/domain/repositories/home_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeRepository _repository = sl<HomeRepository>();

  List<ServiceCategory> _categories = [];
  String? _selectedCategoryId;
  List<Service> _services = [];
  bool _isLoadingCategories = true;
  bool _isLoadingServices = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _repository.getServiceCategories();
      if (mounted) {
        setState(() {
          _categories = categories;
          _isLoadingCategories = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoadingCategories = false);
      }
    }
  }

  Future<void> _loadServices(String categoryId) async {
    setState(() => _isLoadingServices = true);
    try {
      final services = await _repository.getServicesByCategory(categoryId);
      if (mounted) {
        setState(() {
          _services = services;
          _isLoadingServices = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _services = [];
          _isLoadingServices = false;
        });
      }
    }
  }

  void _onCategoryTapped(String categoryId) {
    if (_selectedCategoryId == categoryId) {
      setState(() {
        _selectedCategoryId = null;
        _services = [];
      });
    } else {
      setState(() => _selectedCategoryId = categoryId);
      _loadServices(categoryId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              const _TopAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 96),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _HeroSection(),
                      const _SearchSection(),
                      if (_isLoadingCategories)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else
                        _ServiceFilters(
                          categories: _categories,
                          selectedCategoryId: _selectedCategoryId,
                          onCategoryTapped: _onCategoryTapped,
                        ),
                      if (_selectedCategoryId != null) ...[
                        if (_isLoadingServices)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 48),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        else
                          _ServicesList(services: _services),
                      ] else ...[
                        const _RecommendedSection(),
                        const _PromoGrid(),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Positioned(right: 20, bottom: 96, child: _FabButton()),
        ],
      ),
    );
  }
}

class _TopAppBar extends StatelessWidget {
  const _TopAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFFAF8FF),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 24,
                color: const Color(0xFF004AC6),
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context).homeAppBarTitle,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: const Color(0xFF004AC6),
                  height: 1.5,
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.notifications_outlined,
              size: 24,
              color: const Color(0xFF434655),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 60,
        child: Text(
          AppLocalizations.of(context).homeHeroTitle,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            height: 30 / 24,
            letterSpacing: -0.6,
            color: const Color(0xFF191B23),
          ),
        ),
      ),
    );
  }
}

class _SearchSection extends StatelessWidget {
  const _SearchSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: SizedBox(
        height: 56,
        child: TextField(
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).homeSearchHint,
            hintStyle: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: const Color(0xFF6B7280),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(48, 17, 16, 17),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9999),
              borderSide: const BorderSide(color: Color(0xFFC3C6D7)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9999),
              borderSide: const BorderSide(color: Color(0xFFC3C6D7)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9999),
              borderSide: const BorderSide(
                color: Color(0xFF2563EB),
                width: 1.5,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Icon(
                Icons.search_rounded,
                size: 18,
                color: const Color(0xFF737686),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ServiceFilters extends StatelessWidget {
  final List<ServiceCategory> categories;
  final String? selectedCategoryId;
  final ValueChanged<String> onCategoryTapped;

  const _ServiceFilters({
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategoryTapped,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();
    return Container(
      height: 98,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isActive = selectedCategoryId == cat.id;
          return GestureDetector(
            onTap: () => onCategoryTapped(cat.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF2563EB)
                    : const Color(0xFFFAF8FF),
                border: isActive
                    ? null
                    : Border.all(color: const Color(0xFFC3C6D7)),
                borderRadius: BorderRadius.circular(9999),
                boxShadow: isActive
                    ? [
                        const BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.category_outlined,
                    size: 18,
                    color: isActive
                        ? const Color(0xFFEEEFFF)
                        : const Color(0xFF434655),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    cat.name,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 24 / 16,
                      color: isActive
                          ? const Color(0xFFEEEFFF)
                          : const Color(0xFF434655),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ServicesList extends StatelessWidget {
  final List<Service> services;

  const _ServicesList({required this.services});

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
        child: Center(
          child: Text(
            'No services available',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: const Color(0xFF737686),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Services',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                height: 28 / 20,
                color: const Color(0xFF191B23),
              ),
            ),
          ),
          ...services.map((service) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ServiceCard(service: service),
              )),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final Service service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRouter.providerList,
            arguments: {
              'serviceId': service.id,
              'serviceName': service.name,
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFF3F3FE)),
            borderRadius: BorderRadius.circular(32),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Icon(
                    Icons.build_circle_outlined,
                    size: 28,
                    color: Color(0xFF004AC6),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF191B23),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service.description,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 20 / 14,
                        color: Color(0xFF737686),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecommendedSection extends StatelessWidget {
  const _RecommendedSection();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RecommendedHeader(),
          SizedBox(height: 16),
          SizedBox(height: 284, child: _ProviderCarousel()),
        ],
      ),
    );
  }
}

class _RecommendedHeader extends StatelessWidget {
  const _RecommendedHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context).homeRecommendedTitle,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              height: 28 / 20,
              color: const Color(0xFF191B23),
            ),
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text(
                AppLocalizations.of(context).homeSeeAll,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 24 / 16,
                  color: Color(0xFF004AC6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProviderCarousel extends StatelessWidget {
  const _ProviderCarousel();

  static const _providers = [
    _ProviderData(
      id: 'shine-co',
      name: 'Shine & Co',
      rating: '4.8',
      distanceValue: 1.2,
      tags: ['Repair', 'Tires'],
      status: 'Open',
      statusColor: Color(0xFF6BFF8F),
      statusTextColor: Color(0xFF007432),
      imagePath: 'assets/images/provider_shine_co.jpg',
    ),
    _ProviderData(
      id: 'garage-37',
      name: 'Garage 37',
      rating: '4.9',
      distanceValue: 2.4,
      tags: ['Repair', 'Car Wash'],
      status: 'Open',
      statusColor: Color(0xFF6BFF8F),
      statusTextColor: Color(0xFF007432),
      imagePath: 'assets/images/provider_garage_37.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _providers.length,
      separatorBuilder: (_, _) => const SizedBox(width: 16),
      itemBuilder: (context, index) {
        return _ProviderCard(
          data: _providers[index],
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRouter.providerDetail,
              arguments: _providers[index].id,
            );
          },
        );
      },
    );
  }
}

class _ProviderData {
  final String id;
  final String name;
  final String rating;
  final double distanceValue;
  final List<String> tags;
  final String status;
  final Color statusColor;
  final Color statusTextColor;
  final String imagePath;
  const _ProviderData({
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

class _ProviderCard extends StatelessWidget {
  final _ProviderData data;
  final VoidCallback onTap;

  const _ProviderCard({required this.data, required this.onTap});

  static String _localizeTag(String tag, BuildContext context) {
    final t = AppLocalizations.of(context);
    return switch (tag) {
      'Repair' => t.homeTagRepair,
      'Tires' => t.homeTagTires,
      'Car Wash' => t.homeTagCarWash,
      _ => tag,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onTap,
        child: Container(
          width: 280,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFF3F3FE)),
            borderRadius: BorderRadius.circular(32),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    child: Image.asset(
                      data.imagePath,
                      height: 160,
                      width: 280,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 160,
                          color: const Color(0xFFE3F2FD),
                          child: const Center(
                            child: Icon(
                              Icons.build_circle_outlined,
                              size: 48,
                              color: Color(0x99FFFFFF),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9999),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 13.33,
                            color: const Color(0xFF006E2F),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            data.rating,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              height: 18 / 12,
                              color: Color(0xFF191B23),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.name,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height: 24 / 16,
                            color: Color(0xFF191B23),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: data.statusColor,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            AppLocalizations.of(context).homeStatusOpen,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              height: 15 / 10,
                              letterSpacing: 0.5,
                              color: data.statusTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: const Color(0xFF737686),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${AppLocalizations.of(context).formatNumber(data.distanceValue)} ${AppLocalizations.of(context).homeUnitKm}',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 20 / 14,
                            color: Color(0xFF737686),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: data.tags.map((tag) {
                        final localizedTag = _localizeTag(tag, context);
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F3FE),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Text(
                              localizedTag,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                height: 18 / 12,
                                color: Color(0xFF434655),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PromoGrid extends StatelessWidget {
  const _PromoGrid();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 192,
        child: Row(
          children: [
            Expanded(
              child: _PromoCard(
                label: AppLocalizations.of(context).homePromoLabel,
                title: AppLocalizations.of(context).homePromoTitle,
                backgroundColor: const Color(0xFF2563EB),
                labelColor: const Color(0xFFEEEFFF).withValues(alpha: 0.8),
                titleColor: const Color(0xFFEEEFFF),
                iconColor: const Color(0xFFEEEFFF).withValues(alpha: 0.2),
                icon: Icons.local_offer_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _PromoCard(
                label: AppLocalizations.of(context).homeSupportLabel,
                title: AppLocalizations.of(context).homeSupportTitle,
                backgroundColor: const Color(0xFFBC4800),
                labelColor: const Color(0xFFFFEDE6).withValues(alpha: 0.8),
                titleColor: const Color(0xFFFFEDE6),
                iconColor: const Color(0xFFFFEDE6).withValues(alpha: 0.2),
                icon: Icons.headset_mic_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  final String label;
  final String title;
  final Color backgroundColor;
  final Color labelColor;
  final Color titleColor;
  final Color iconColor;
  final IconData icon;

  const _PromoCard({
    required this.label,
    required this.title,
    required this.backgroundColor,
    required this.labelColor,
    required this.titleColor,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -5,
            top: -12,
            child: Transform.rotate(
              angle: 12 * 3.14159 / 180,
              child: Opacity(
                opacity: 0.2,
                child: Icon(icon, size: 40, color: iconColor),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    height: 16 / 12,
                    letterSpacing: 0.6,
                    color: labelColor,
                  ),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 20 / 16,
                  color: titleColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FabButton extends StatelessWidget {
  const _FabButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF2563EB),
        borderRadius: BorderRadius.circular(9999),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(9999),
          onTap: () {},
          child: const Center(
            child: Icon(Icons.add_rounded, size: 24, color: Color(0xFFEEEFFF)),
          ),
        ),
      ),
    );
  }
}
