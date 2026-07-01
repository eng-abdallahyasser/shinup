import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shineup/core/di/service_locator.dart';
import 'package:shineup/core/network/api_client.dart';
import 'package:shineup/core/routes/app_pages.dart';
import 'package:shineup/features/auth/domain/repositories/auth_repository.dart';
import 'package:shineup/features/onboarding/domain/repositories/onboarding_repository.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeScale;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeScale = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _controller.forward();

    // Check auth status then navigate
    _timer = Timer(const Duration(seconds: 2), () async {
      if (!mounted) return;
      final onboardingRepo = sl<OnboardingRepository>();
      final onboardingCompleted = await onboardingRepo.isOnboardingCompleted();
      if (!mounted) return;
      if (!onboardingCompleted) {
        Navigator.of(context).pushReplacementNamed(AppRouter.onboarding);
        return;
      }
      final authRepo = sl<AuthRepository>();
      final token = authRepo.getToken();
      if (!mounted) return;
      if (token != null && token.isNotEmpty) {
        // Validate the token by fetching the user profile
        try {
          await authRepo.getProfile();
          // Token is valid — proceed
        } on ApiException catch (e) {
          if (e.statusCode == 401) {
            // Token expired/invalid — clear and redirect to login
            await authRepo.clearToken();
            if (!mounted) return;
            Navigator.of(context).pushReplacementNamed(AppRouter.login);
            return;
          }
          // Other API errors (5xx, etc.) — proceed anyway, token might be fine
        } catch (_) {
          // Network errors — proceed, token might still be valid
        }

        if (!mounted) return;
        final locationGranted = await _checkLocationPermission();
        if (!mounted) return;
        if (!locationGranted) {
          Navigator.of(context).pushReplacementNamed(
            AppRouter.locationAccess,
            arguments: {'redirectRoute': AppRouter.main},
          );
        } else {
          Navigator.of(context).pushReplacementNamed(AppRouter.main);
        }
      } else {
        Navigator.of(context).pushReplacementNamed(AppRouter.login);
      }
    });
  }

  /// Checks if location permission is already granted.
  /// Returns true if permission is granted (whileInUse or always).
  Future<bool> _checkLocationPermission() async {
    try {
      final permission = await Geolocator.checkPermission();
      return permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
    } catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
        ),
        child: FadeTransition(
          opacity: _fadeScale,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.85, end: 1.0).animate(_fadeScale),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/app_icon.jpg',
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const SizedBox(
                      width: 140,
                      height: 140,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'SHINEUP',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'CLEAN . SHINE . PROTECT',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 48),
                const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
