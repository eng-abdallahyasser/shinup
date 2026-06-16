import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinup/features/onboarding/data/models/onboarding_model.dart';

class OnboardingLocalDataSource {
  final SharedPreferences _prefs;

  OnboardingLocalDataSource(this._prefs);

  static const _onboardingCompletedKey = 'onboarding_completed';

  /// Returns the 4 static onboarding steps.
  List<OnboardingData> getSteps() {
    return const [
      OnboardingData(
        imageAsset: 'assets/onboarding/1.jpg',
        title: 'Book a Service',
        subtitle:
            'Schedule your car cleaning appointment in seconds. Choose the service that fits your needs.',
        badgeText: 'Easy Booking',
        badgeIcon: 'calendar',
      ),
      OnboardingData(
        imageAsset: 'assets/onboarding/2.jpg',
        title: 'Track Progress',
        subtitle:
            'Follow your car\'s cleaning journey in real-time with live updates every step of the way.',
        badgeText: 'Premium',
        badgeIcon: 'star',
      ),
      OnboardingData(
        imageAsset: 'assets/onboarding/3.jpg',
        title: 'Premium Products',
        subtitle:
            'We use only premium eco-friendly products and professional-grade equipment for a showroom finish.',
        badgeText: 'Eco Friendly',
        badgeIcon: 'leaf',
        badgeHighlight: true,
      ),
      OnboardingData(
        imageAsset: 'assets/onboarding/4.jpg',
        title: 'Drive Happy',
        subtitle:
            'Your satisfaction is 100% guaranteed. Enjoy a spotless, showroom-quality shine every time.',
        badgeText: 'Guaranteed',
        badgeIcon: 'shield',
        badgeHighlight: true,
      ),
    ];
  }

  Future<bool> isOnboardingCompleted() async {
    return _prefs.getBool(_onboardingCompletedKey) ?? false;
  }

  Future<void> setOnboardingCompleted() async {
    await _prefs.setBool(_onboardingCompletedKey, true);
  }

  Future<void> resetOnboarding() async {
    await _prefs.remove(_onboardingCompletedKey);
  }
}
