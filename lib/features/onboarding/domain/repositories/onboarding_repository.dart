import 'package:shinup/features/onboarding/data/models/onboarding_model.dart';

abstract class OnboardingRepository {
  List<OnboardingData> getSteps();
  Future<bool> isOnboardingCompleted();
  Future<void> setOnboardingCompleted();
  Future<void> resetOnboarding();
}
