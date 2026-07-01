import 'package:shineup/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:shineup/features/onboarding/data/models/onboarding_model.dart';
import 'package:shineup/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource _localDataSource;

  OnboardingRepositoryImpl(this._localDataSource);

  @override
  List<OnboardingData> getSteps() => _localDataSource.getSteps();

  @override
  Future<bool> isOnboardingCompleted() =>
      _localDataSource.isOnboardingCompleted();

  @override
  Future<void> setOnboardingCompleted() =>
      _localDataSource.setOnboardingCompleted();

  @override
  Future<void> resetOnboarding() => _localDataSource.resetOnboarding();
}
