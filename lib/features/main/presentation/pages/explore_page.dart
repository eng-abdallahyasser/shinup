import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

/// Explore page displaying an interactive map with nearby service providers.
///
/// Features:
/// - OpenStreetMap tiles via [FlutterMap]
/// - User location tracking via [Geolocator]
/// - Floating overlay pill showing current service category
/// - Side toggle buttons (search + my-location)
/// - Bottom service provider card with details
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final MapController _mapController = MapController();

  /// The user's current location, or a sensible default if unavailable.
  LatLng _currentPosition = const LatLng(24.7136, 46.6753); // Riyadh default

  StreamSubscription<Position>? _positionStream;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    _mapController.dispose();
    super.dispose();
  }

  /// Request permission and start listening to position updates.
  Future<void> _initLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final req = await Geolocator.requestPermission();
        if (req == LocationPermission.denied ||
            req == LocationPermission.deniedForever) {
          return; // User denied – stays on default location
        }
      }

      // Get last known position as a quick initial fix
      final pos = await Geolocator.getLastKnownPosition();
      if (pos != null && mounted) {
        setState(() {
          _currentPosition = LatLng(pos.latitude, pos.longitude);
        });
      }

      // Listen for ongoing updates
      _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 50,
        ),
      ).listen((position) {
        if (mounted) {
          setState(() {
            _currentPosition = LatLng(position.latitude, position.longitude);
          });
        }
      });
    } catch (_) {
      // Location unavailable – keep default
    }
  }

  /// Move the map to the user's current location.
  void _goToMyLocation() {
    _mapController.move(_currentPosition, 15);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // ── Full-screen Map ─────────────────────────────────────
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentPosition,
              initialZoom: 14,
              onMapEvent: (_) {},
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.shinup',
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

          // ── TopAppBar ───────────────────────────────────────────
          _MapTopAppBar(),

          // ── Floating Selection Overlay ──────────────────────────
          const Positioned(
            left: 0,
            right: 0,
            top: 80,
            child: _FloatingSelectionPill(),
          ),

          // ── Toggle Buttons (Search + My Location) ───────────────
          Positioned(
            right: 20,
            top: 144,
            child: Column(
              children: [
                _MapToggleButton(
                  icon: Icons.search_rounded,
                  backgroundColor: Colors.white,
                  iconColor: const Color(0xFF004AC6),
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _MapToggleButton(
                  icon: Icons.my_location_rounded,
                  backgroundColor: const Color(0xFF004AC6),
                  iconColor: Colors.white,
                  onTap: _goToMyLocation,
                ),
              ],
            ),
          ),

          // ── Floating Service Card at Bottom ─────────────────────
          const Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: _ServiceCard(),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Map Top AppBar
// ═════════════════════════════════════════════════════════════════════════════

class _MapTopAppBar extends StatelessWidget {
  const _MapTopAppBar();

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
          // ❖ Menu icon + Brand
          Row(
            children: [
              Icon(Icons.menu,
                  size: 20, color: const Color(0xFF004AC6)),
              const SizedBox(width: 8),
              Text(
                'Shinup',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 30 / 24,
                  color: const Color(0xFF004AC6),
                ),
              ),
            ],
          ),
          const Spacer(),
          // ❖ Notification bell
          Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(Icons.notifications_outlined,
                size: 20, color: const Color(0xFF434655)),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Floating Selection Pill
// ═════════════════════════════════════════════════════════════════════════════

class _FloatingSelectionPill extends StatelessWidget {
  const _FloatingSelectionPill();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
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
            Icon(Icons.location_on_rounded,
                size: 16, color: const Color(0xFF004AC6)),
            const SizedBox(width: 8),
            const Text(
              'Full Exterior Polish\n& Wax',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 20 / 14,
                color: Color(0xFF191B23),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Map Toggle Button (Search / My Location)
// ═════════════════════════════════════════════════════════════════════════════

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

// ═════════════════════════════════════════════════════════════════════════════
//  Floating Service Card
// ═════════════════════════════════════════════════════════════════════════════

class _ServiceCard extends StatelessWidget {
  const _ServiceCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 180,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Thumbnail image ─────────────────────────────────
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  Icons.build_circle_outlined,
                  size: 36,
                  color: Colors.blue.withValues(alpha: 0.4),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // ── Text content ────────────────────────────────────
            Expanded(
              child: SizedBox(
                height: 148,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + OPEN badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Shine & Co',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              height: 24 / 16,
                              color: Color(0xFF191B23),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6BFF8F),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star_rounded,
                                  size: 12,
                                  color: const Color(0xFF007432)),
                              const SizedBox(width: 4),
                              const Text(
                                'OPEN',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  height: 16 / 12,
                                  letterSpacing: 0.6,
                                  color: Color(0xFF007432),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Service description
                    const Text(
                      'Full Exterior Polish\n& Wax',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 20 / 14,
                        color: Color(0xFF434655),
                      ),
                    ),

                    const Spacer(),

                    // Bottom row: directions link + distance + arrow button
                    Row(
                      children: [
                        // Get directions link
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.navigation_rounded,
                                  size: 14,
                                  color: const Color(0xFF004AC6)),
                              const SizedBox(width: 4),
                              const Text(
                                'Get directions',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  height: 16 / 12,
                                  letterSpacing: 0.6,
                                  color: Color(0xFF004AC6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Distance
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on_outlined,
                                size: 14,
                                color: const Color(0xFF434655)),
                            const SizedBox(width: 4),
                            const Text(
                              '2.4 km',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 16 / 12,
                                letterSpacing: 0.6,
                                color: Color(0xFF434655),
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Arrow button
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF004AC6),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(9999),
                              onTap: () {},
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
