import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shineup/core/localization/app_localizations.dart';
import 'package:shineup/core/routes/app_pages.dart';

class LocationAccessPage extends StatefulWidget {
  /// The route to navigate to after permission is granted or skipped.
  final String? redirectRoute;
  final Object? redirectArguments;

  const LocationAccessPage({
    super.key,
    this.redirectRoute,
    this.redirectArguments,
  });

  @override
  State<LocationAccessPage> createState() => _LocationAccessPageState();
}

class _LocationAccessPageState extends State<LocationAccessPage> {
  bool _isRequesting = false;

  Future<void> _requestPermission() async {
    setState(() => _isRequesting = true);

    try {
      final permission = await Geolocator.requestPermission();
      if (!mounted) return;

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        _navigateForward();
        return;
      }
    } catch (_) {
      // Permission request failed — stay on page
    }

    if (!mounted) return;
    setState(() => _isRequesting = false);
  }

  void _skip() {
    _navigateForward();
  }

  void _navigateForward() {
    final route = widget.redirectRoute ?? AppRouter.main;
    if (widget.redirectArguments != null) {
      Navigator.of(context).pushReplacementNamed(
        route,
        arguments: widget.redirectArguments,
      );
    } else {
      Navigator.of(context).pushReplacementNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 64,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: _skip,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        size: 20,
                        color: Color(0xFF191B23),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ── Main content ────────────────────────────────────────
            Expanded(
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // ── Location Beacon Illustration ───────────────────
                  SizedBox(
                    width: 280,
                    height: 304,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer ring
                        Container(
                          width: 280,
                          height: 280,
                          decoration: const BoxDecoration(
                            color: Color(0x1A2563EB),
                            shape: BoxShape.circle,
                          ),
                        ),
                        // Middle ring
                        Container(
                          width: 216,
                          height: 216,
                          decoration: const BoxDecoration(
                            color: Color(0x332563EB),
                            shape: BoxShape.circle,
                          ),
                        ),
                        // Center card
                        Container(
                          width: 192,
                          height: 192,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(48),
                            border: Border.all(
                              color: const Color(0x4DC3C6D7),
                            ),
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
                          child: Stack(
                            children: [
                              // Location pin icon (centered)
                              const Center(
                                child: Icon(
                                  Icons.location_on_rounded,
                                  size: 64,
                                  color: Color(0xFF004AC6),
                                ),
                              ),
                              // Blue badge at bottom-right
                              Positioned(
                                right: 17,
                                bottom: 17,
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF004AC6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.my_location_rounded,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 1),

                  // ── Heading & Subtitle ─────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        Text(
                          t.locationAccessTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            letterSpacing: -0.6,
                            color: Color(0xFF191B23),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          t.locationAccessSubtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.625,
                            color: Color(0xFF434655),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 1),

                  // ── Trust Indicator Bento ──────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F3FE),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.gps_fixed_rounded,
                                  size: 16,
                                  color: Color(0xFF004AC6),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  t.locationAccessTrustAccurate,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    letterSpacing: 0.6,
                                    color: Color(0xFF434655),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F3FE),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.bolt_rounded,
                                  size: 16,
                                  color: Color(0xFF004AC6),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  t.locationAccessTrustFast,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    letterSpacing: 0.6,
                                    color: Color(0xFF434655),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 2),
                ],
              ),
            ),

            // ── Fixed Action Footer ─────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFFAF8FF),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Enable Location button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isRequesting ? null : _requestPermission,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: const Color(0xFFEEEFFF),
                        disabledBackgroundColor:
                            const Color(0xFF2563EB).withValues(alpha: 0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        elevation: 0,
                      ),
                      child: _isRequesting
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Color(0xFFEEEFFF),
                              ),
                            )
                          : Text(
                              t.locationAccessEnable,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Maybe Later button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: _skip,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF191B23),
                        side: const BorderSide(color: Color(0xFFC3C6D7)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        t.locationAccessMaybeLater,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Privacy assurance
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      t.locationAccessPrivacy,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 1.43,
                        color: Color(0xFF737686),
                      ),
                    ),
                  ),

                  // Spacer for system bar
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
