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
import 'package:shinup/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:shinup/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:shinup/features/booking/domain/repositories/booking_repository.dart';
import 'package:shinup/features/explore/data/datasources/explore_remote_datasource.dart';
import 'package:shinup/features/explore/data/repositories/explore_repository_impl.dart';
import 'package:shinup/features/explore/domain/repositories/explore_repository.dart';
import 'package:shinup/features/home/data/datasources/home_remote_datasource.dart';
import 'package:shinup/features/home/data/repositories/home_repository_impl.dart';
import 'package:shinup/features/home/domain/repositories/home_repository.dart';
import 'package:shinup/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:shinup/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:shinup/features/profile/domain/repositories/profile_repository.dart';
import 'package:shinup/features/provider/data/datasources/provider_remote_datasource.dart';
import 'package:shinup/features/provider/data/repositories/provider_repository_impl.dart';
import 'package:shinup/features/provider/domain/repositories/provider_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  // Localization
  sl.registerLazySingleton(() => LocaleCubit(sl<SharedPreferences>()));

  // Network
  final apiClient = ApiClient();
  apiClient.setLanguageCode(prefs.getString('locale') ?? 'ar');
  sl.registerLazySingleton<ApiClient>(() => apiClient);

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

  // Profile - Data layer
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(sl<ApiClient>()),
  );

  // Profile - Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      sl<ProfileRemoteDataSource>(),
      sl<ApiClient>(),
      sl<SharedPreferences>(),
    ),
  );

  // Home - Data layer
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(sl<ApiClient>()),
  );

  // Home - Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<HomeRemoteDataSource>()),
  );

  // Explore - Data layer
  sl.registerLazySingleton<ExploreRemoteDataSource>(
    () => ExploreRemoteDataSource(sl<ApiClient>()),
  );

  // Explore - Repository
  sl.registerLazySingleton<ExploreRepository>(
    () => ExploreRepositoryImpl(sl<ExploreRemoteDataSource>()),
  );

  // Booking - Data layer
  sl.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSource(sl<ApiClient>()),
  );

  // Booking - Repository
  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(sl<BookingRemoteDataSource>()),
  );

  // Provider - Data layer
  sl.registerLazySingleton<ProviderRemoteDataSource>(
    () => ProviderRemoteDataSource(sl<ApiClient>()),
  );

  // Provider - Repository
  sl.registerLazySingleton<ProviderRepository>(
    () => ProviderRepositoryImpl(sl<ProviderRemoteDataSource>()),
  );
}
