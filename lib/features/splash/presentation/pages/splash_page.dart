import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shinup/core/di/service_locator.dart';
import 'package:shinup/core/routes/app_pages.dart';
import 'package:shinup/features/auth/domain/repositories/auth_repository.dart';

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
    _timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      final authRepo = sl<AuthRepository>();
      final token = authRepo.getToken();
      if (token != null && token.isNotEmpty) {
        Navigator.of(context).pushReplacementNamed(AppRouter.counter);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRouter.login);
      }
    });
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
                  'SHINUP',
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
