import 'package:flutter/material.dart';
import 'package:shineup/core/di/service_locator.dart';
import 'package:shineup/core/localization/app_localizations.dart';
import 'package:shineup/core/routes/app_pages.dart';
import 'package:shineup/features/onboarding/data/models/onboarding_model.dart';
import 'package:shineup/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:shineup/features/onboarding/presentation/widgets/onboarding_step.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pageController;
  late final List<OnboardingData> _steps;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _steps = sl<OnboardingRepository>().getSteps();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get _isLastStep => _currentPage == _steps.length - 1;

  void _onNext() {
    if (_isLastStep) {
      _completeOnboarding();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSkip() {
    _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    await sl<OnboardingRepository>().setOnboardingCompleted();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRouter.login);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Navigation Bar ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 64,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.appTitle,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Color(0xFF004AC6),
                      ),
                    ),
                    GestureDetector(
                      onTap: _onSkip,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          t.onboardingSkip,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xFF434655),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Main Content Area (expands to fill) ─────────────────────
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _steps.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return OnboardingStep(data: _steps[index]);
                },
              ),
            ),

            // ── Fixed Footer ────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xCCFAF8FF),
                    Color(0xFFFAF8FF),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Progress Indicators
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_steps.length, (index) {
                        final isActive = index == _currentPage;
                        return Container(
                          width: isActive ? 32 : 6,
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFF2563EB)
                                : const Color(0xFFC3C6D7),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Next / Get Started Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        elevation: 2,
                        shadowColor: Colors.black.withValues(alpha: 0.1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _isLastStep
                                ? t.onboardingGetStarted
                                : t.onboardingNext,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _isLastStep
                                ? Icons.check_circle_outline
                                : Icons.arrow_forward,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Trust Badges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _trustBadge(
                        icon: Icons.support_agent_outlined,
                        label: t.trustSupport,
                      ),
                      const SizedBox(width: 72),
                      _trustBadge(
                        icon: Icons.timer_outlined,
                        label: t.trustExpress,
                      ),
                      const SizedBox(width: 72),
                      _trustBadge(
                        icon: Icons.star_outline,
                        label: t.trustQuality,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trustBadge({required IconData icon, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: const Color(0xFF737686),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: Color(0xFF737686),
          ),
        ),
      ],
    );
  }
}
