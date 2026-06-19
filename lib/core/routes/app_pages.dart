import 'package:flutter/material.dart';
import 'package:shinup/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:shinup/features/auth/presentation/pages/login_page.dart';
import 'package:shinup/features/auth/presentation/pages/otp_page.dart';
import 'package:shinup/features/auth/presentation/pages/register_page.dart';
import 'package:shinup/features/auth/presentation/pages/reset_password_page.dart';
import 'package:shinup/features/main/presentation/pages/main_shell.dart';
import 'package:shinup/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:shinup/features/profile/presentation/pages/add_vehicle_page.dart';
import 'package:shinup/features/profile/presentation/pages/car_detail_page.dart';
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
  static const String addVehicle = '/add-vehicle';
  static const String carDetail = '/car-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
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
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
    }
  }
}
