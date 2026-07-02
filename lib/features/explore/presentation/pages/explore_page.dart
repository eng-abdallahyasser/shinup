import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shineup/core/di/service_locator.dart';
import 'package:shineup/core/localization/app_localizations.dart';
import 'package:shineup/features/explore/domain/repositories/explore_repository.dart';
import 'package:shineup/features/home/data/models/home_models.dart';
import 'package:shineup/features/home/domain/repositories/home_repository.dart';
import 'package:shineup/features/provider/data/models/nearby_worker_model.dart';
import 'package:shineup/core/routes/app_pages.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final MapController _mapController = MapController();
  final ExploreRepository _exploreRepository = sl<ExploreRepository>();
  final HomeRepository _homeRepository = sl<HomeRepository>();

  LatLng _currentPosition = const LatLng(24.7136, 46.6753);
  List<NearbyWorkerResult> _workers = [];
  NearbyWorkerResult? _selectedWorker;
  bool _isLoadingWorkers = false;

  List<ServiceCategory> _categories = [];
  List<Service> _allServices = [];
  Set<String> _selectedServiceIds = {};


  StreamSubscription<Position>? _positionStream;

  @override
  void initState() {
    super.initState();
    _initLocation();
    _loadServiceCatalog();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _initLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      final granted = permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
      if (!granted) return;

      final pos = await Geolocator.getLastKnownPosition();
      if (pos != null && mounted) {
        final latLng = LatLng(pos.latitude, pos.longitude);
        setState(() => _currentPosition = latLng);
        _loadNearbyWorkers(latLng);
      }

      _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 50,
        ),
      ).listen((position) {
        if (!mounted) return;
        final latLng = LatLng(position.latitude, position.longitude);
        setState(() => _currentPosition = latLng);
      });
    } catch (_) {}
  }

  Future<void> _loadServiceCatalog() async {
    try {
      final categories = await _homeRepository.getServiceCategories();
      final List<Service> allServices = [];
      for (final cat in categories) {
        try {
          final services = await _homeRepository.getServicesByCategory(cat.id);
          allServices.addAll(services);
        } catch (_) {}
      }
      if (mounted) {
        setState(() {
          _categories = categories;
          _allServices = allServices;
        });
      }
    } catch (_) {}
  }

  Future<void> _loadNearbyWorkers(LatLng? position) async {
    final pos = position ?? _currentPosition;
    setState(() {
      _isLoadingWorkers = true;
      _selectedWorker = null;
    });
    try {
      final response = await _exploreRepository.getNearbyWorkers(
        latitude: pos.latitude,
        longitude: pos.longitude,
        serviceIds:
            _selectedServiceIds.isNotEmpty ? _selectedServiceIds.toList() : null,
        limit: 20,
      );
      if (mounted) {
        setState(() {
          _workers = response.results;
          _isLoadingWorkers = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingWorkers = false);
    }
  }

  void _goToMyLocation() {
    _mapController.move(_currentPosition, 15);
  }

  void _onWorkerTapped(NearbyWorkerResult worker) {
    setState(() => _selectedWorker = worker);
    _mapController.move(LatLng(worker.latitude, worker.longitude), 15);
  }

  void _onMapTapped() {
    setState(() => _selectedWorker = null);
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (_) => _ServiceFilterSheet(
        categories: _categories,
        allServices: _allServices,
        selectedServiceIds: _selectedServiceIds,
        onApply: (selected) {
          setState(() => _selectedServiceIds = selected);
          _loadNearbyWorkers(null);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentPosition,
              initialZoom: 14,
              onTap: (_, _) => _onMapTapped(),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.shineup',
              ),
              MarkerLayer(
                markers: [
                  _buildUserMarker(),
                  ..._workers.map(_buildWorkerMarker),
                ],
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    '© OpenStreetMap contributors',
                  ),
                ],
              ),
            ],
          ),

          if (_isLoadingWorkers)
            const Positioned.fill(
              child: Center(child: CircularProgressIndicator()),
            ),

          Positioned(
            left: 0,
            right: 0,
            top: 20,
            child: _FloatingFilterPill(
              selectedCount: _selectedServiceIds.length,
              onTap: _openFilterSheet,
            ),
          ),

          Positioned(
            right: 20,
            top: 20,
            child: Column(
              children: [
                _MapToggleButton(
                  icon: Icons.my_location_rounded,
                  backgroundColor: const Color(0xFF004AC6),
                  iconColor: Colors.white,
                  onTap: _goToMyLocation,
                ),
              ],
            ),
          ),

          if (_selectedWorker != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: _ProviderBottomCard(
                worker: _selectedWorker!,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRouter.providerDetail,
                    arguments: _selectedWorker!.providerMemberId,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Marker _buildUserMarker() {
    return Marker(
      point: _currentPosition,
      width: 30,
      height: 30,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF004AC6),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
          child: Icon(Icons.person, size: 14, color: Colors.white),
        ),
      ),
    );
  }

  Marker _buildWorkerMarker(NearbyWorkerResult worker) {
    final isSelected = _selectedWorker?.providerMemberId == worker.providerMemberId;
    return Marker(
      point: LatLng(worker.latitude, worker.longitude),
      width: isSelected ? 48 : 36,
      height: isSelected ? 48 : 36,
      child: GestureDetector(
        onTap: () => _onWorkerTapped(worker),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF2563EB)
                : const Color(0xFF004AC6),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: isSelected ? 3 : 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.build_circle_outlined,
              size: isSelected ? 22 : 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingFilterPill extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onTap;

  const _FloatingFilterPill({
    required this.selectedCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(9999),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.95),
              border: Border.all(color: const Color(0xFFC3C6D7)),
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.filter_alt_rounded,
                    size: 16, color: Color(0xFF004AC6)),
                const SizedBox(width: 8),
                Text(
                  selectedCount == 0
                      ? 'All Services'
                      : '$selectedCount service${selectedCount == 1 ? '' : 's'} selected',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 20 / 14,
                    color: Color(0xFF191B23),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down_rounded,
                    size: 18, color: Color(0xFF434655)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MapToggleButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _MapToggleButton({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(48),
        onTap: onTap,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(48),
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
          child: Center(
            child: Icon(icon, size: 20, color: iconColor),
          ),
        ),
      ),
    );
  }
}

class _ProviderBottomCard extends StatelessWidget {
  final NearbyWorkerResult worker;
  final VoidCallback onTap;

  const _ProviderBottomCard({
    required this.worker,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final distanceKm = (worker.distanceMeters / 1000);
    final displayName = worker.companyName ?? worker.providerName;
    final firstService = worker.items.isNotEmpty ? worker.items.first : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFC3C6D7)),
          borderRadius: BorderRadius.circular(32),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
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
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 24 / 16,
                          color: Color(0xFF191B23),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              size: 14, color: const Color(0xFF737686)),
                          const SizedBox(width: 4),
                          Text(
                            '${t.formatNumber(distanceKm)} ${t.homeUnitKm}',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              height: 18 / 13,
                              color: Color(0xFF737686),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.timer_outlined,
                              size: 14, color: const Color(0xFF737686)),
                          const SizedBox(width: 4),
                          Text(
                            '${worker.minutesEta} min',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              height: 18 / 13,
                              color: Color(0xFF737686),
                            ),
                          ),
                        ],
                      ),
                      if (firstService != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              firstService.serviceName,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                height: 18 / 13,
                                color: Color(0xFF434655),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${firstService.priceCustomer} ${firstService.currency}',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                height: 18 / 13,
                                color: Color(0xFF004AC6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 20 / 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceFilterSheet extends StatefulWidget {
  final List<ServiceCategory> categories;
  final List<Service> allServices;
  final Set<String> selectedServiceIds;
  final ValueChanged<Set<String>> onApply;

  const _ServiceFilterSheet({
    required this.categories,
    required this.allServices,
    required this.selectedServiceIds,
    required this.onApply,
  });

  @override
  State<_ServiceFilterSheet> createState() => _ServiceFilterSheetState();
}

class _ServiceFilterSheetState extends State<_ServiceFilterSheet> {
  late Set<String> _localSelected;
  String? _activeCategoryId;

  @override
  void initState() {
    super.initState();
    _localSelected = Set.from(widget.selectedServiceIds);
    if (widget.categories.isNotEmpty) {
      _activeCategoryId = widget.categories.first.id;
    }
  }

  List<Service> get _activeServices {
    if (_activeCategoryId == null) return [];
    return widget.allServices
        .where((s) => s.categoryId == _activeCategoryId)
        .toList();
  }

  void _toggleService(String serviceId) {
    setState(() {
      if (_localSelected.contains(serviceId)) {
        _localSelected.remove(serviceId);
      } else {
        _localSelected.add(serviceId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, safeBottom + 20),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.65,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFC3C6D7),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Filter by Service',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              height: 28 / 20,
              color: Color(0xFF191B23),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = widget.categories[index];
                final isActive = _activeCategoryId == cat.id;
                return GestureDetector(
                  onTap: () => setState(() => _activeCategoryId = cat.id),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF2563EB)
                          : const Color(0xFFF3F3FE),
                      borderRadius: BorderRadius.circular(9999),
                      border: isActive
                          ? null
                          : Border.all(color: const Color(0xFFC3C6D7)),
                    ),
                    child: Text(
                      cat.name,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 20 / 14,
                        color: isActive
                            ? const Color(0xFFEEEFFF)
                            : const Color(0xFF434655),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          if (_activeServices.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  'No services in this category',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF737686),
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _activeServices.map((service) {
                    final isSelected =
                        _localSelected.contains(service.id);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => _toggleService(service.id),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFEFF6FF)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF2563EB)
                                    : const Color(0xFFE5E7EB),
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF2563EB)
                                        : const Color(0xFFF3F4F6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    isSelected
                                        ? Icons.check_circle
                                        : Icons.build_outlined,
                                    size: 20,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF737686),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        service.name,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          height: 20 / 14,
                                          color: const Color(0xFF191B23),
                                        ),
                                      ),
                                      if (service.description.isNotEmpty)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Text(
                                            service.description,
                                            style: const TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              height: 16 / 12,
                                              color: Color(0xFF9CA3AF),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    size: 20,
                                    color: const Color(0xFF2563EB),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                widget.onApply(_localSelected);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
                elevation: 0,
              ),
              child: Text(
                _localSelected.isEmpty
                    ? 'Show All'
                    : 'Show ${_localSelected.length} service${_localSelected.length == 1 ? '' : 's'}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 20 / 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
