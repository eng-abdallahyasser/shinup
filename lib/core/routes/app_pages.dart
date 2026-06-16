import 'package:flutter/material.dart';
import 'package:shinup/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:shinup/features/auth/presentation/pages/login_page.dart';
import 'package:shinup/features/auth/presentation/pages/otp_page.dart';
import 'package:shinup/features/auth/presentation/pages/register_page.dart';
import 'package:shinup/features/auth/presentation/pages/reset_password_page.dart';
import 'package:shinup/features/counter/presentation/pages/counter_page.dart';
import 'package:shinup/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  AppRouter._();

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String counter = '/counter';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
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
      case counter:
        return MaterialPageRoute(
          builder: (_) => const CounterPage(),
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
