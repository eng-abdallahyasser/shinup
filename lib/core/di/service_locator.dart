import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinup/core/network/api_client.dart';
import 'package:shinup/core/localization/locale_cubit.dart';
import 'package:shinup/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:shinup/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:shinup/features/auth/domain/repositories/auth_repository.dart';
import 'package:shinup/features/counter/data/datasources/counter_local_datasource.dart';
import 'package:shinup/features/counter/data/repositories/counter_repository_impl.dart';
import 'package:shinup/features/counter/domain/repositories/counter_repository.dart';
import 'package:shinup/features/counter/domain/usecases/get_counter_usecase.dart';
import 'package:shinup/features/counter/domain/usecases/increment_counter_usecase.dart';
import 'package:shinup/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:shinup/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:shinup/features/onboarding/domain/repositories/onboarding_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  // Localization
  sl.registerLazySingleton(() => LocaleCubit(sl<SharedPreferences>()));

  // Network
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  // Onboarding - Data layer
  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSource(sl<SharedPreferences>()),
  );

  // Onboarding - Repository
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(
      sl<OnboardingLocalDataSource>(),
    ),
  );

  // Auth - Data layer
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<ApiClient>()),
  );

  // Auth - Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
      sl<ApiClient>(),
      sl<SharedPreferences>(),
    ),
  );

  // Counter - Data layer
  sl.registerLazySingleton<CounterLocalDataSource>(
    () => CounterLocalDataSource(sl()),
  );

  // Counter - Repository
  sl.registerLazySingleton<CounterRepository>(
    () => CounterRepositoryImpl(sl<CounterLocalDataSource>()),
  );

  // Domain layer - Use Cases
  sl.registerLazySingleton<GetCounterUseCase>(
    () => GetCounterUseCase(sl<CounterRepository>()),
  );
  sl.registerLazySingleton<IncrementCounterUseCase>(
    () => IncrementCounterUseCase(sl<CounterRepository>()),
  );
}
