import 'package:flutter/material.dart';
import 'package:shinup/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:shinup/features/auth/presentation/pages/login_page.dart';
import 'package:shinup/features/auth/presentation/pages/otp_page.dart';
import 'package:shinup/features/auth/presentation/pages/register_page.dart';
import 'package:shinup/features/auth/presentation/pages/reset_password_page.dart';
import 'package:shinup/features/booking/presentation/pages/booking_step2_page.dart';
import 'package:shinup/features/booking/presentation/pages/booking_step3_page.dart';
import 'package:shinup/features/location/presentation/pages/location_access_page.dart';
import 'package:shinup/features/main/presentation/pages/main_shell.dart';
import 'package:shinup/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:shinup/features/profile/presentation/pages/add_address_page.dart';
import 'package:shinup/features/profile/presentation/pages/add_vehicle_page.dart';
import 'package:shinup/features/profile/presentation/pages/address_detail_page.dart';
import 'package:shinup/features/profile/presentation/pages/car_detail_page.dart';
import 'package:shinup/features/provider/presentation/pages/provider_detail_page.dart';
import 'package:shinup/features/provider/presentation/pages/provider_list_page.dart';
import 'package:shinup/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  AppRouter._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String main = '/main';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String locationAccess = '/location-access';
  static const String addVehicle = '/add-vehicle';
  static const String carDetail = '/car-detail';
  static const String addAddress = '/add-address';
  static const String addressDetail = '/address-detail';
  static const String providerDetail = '/provider-detail';
  static const String providerList = '/provider-list';
  static const String bookingStep2 = '/booking-step2';
  static const String bookingStep3 = '/booking-step3';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
      case locationAccess:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => LocationAccessPage(
            redirectRoute: args?['redirectRoute'] as String?,
            redirectArguments: args?['redirectArguments'],
          ),
          settings: settings,
        );
      case onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
          settings: settings,
        );
      case main:
        return MaterialPageRoute(
          builder: (_) => const MainShell(),
          settings: settings,
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
          settings: settings,
        );
      case otp:
        final userId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => OtpPage(userId: userId),
          settings: settings,
        );
      case forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordPage(),
          settings: settings,
        );
      case resetPassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordPage(),
          settings: settings,
        );
      case addVehicle:
        return MaterialPageRoute(
          builder: (_) => const AddVehiclePage(),
          settings: settings,
        );
      case carDetail:
        final carId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CarDetailPage(carId: carId),
          settings: settings,
        );
      case addAddress:
        return MaterialPageRoute(
          builder: (_) => const AddAddressPage(),
          settings: settings,
        );
      case addressDetail:
        final addressId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AddressDetailPage(addressId: addressId),
          settings: settings,
        );
      case providerDetail:
        final providerId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ProviderDetailPage(providerId: providerId),
          settings: settings,
        );
      case providerList:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ProviderListPage(
            serviceId: args['serviceId'] as String,
            serviceName: args['serviceName'] as String,
          ),
          settings: settings,
        );
      case bookingStep2:
        return MaterialPageRoute(
          builder: (_) => const BookingStep2Page(),
          settings: settings,
        );
      case bookingStep3:
        return MaterialPageRoute(
          builder: (_) => const BookingStep3Page(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
    }
  }
}
