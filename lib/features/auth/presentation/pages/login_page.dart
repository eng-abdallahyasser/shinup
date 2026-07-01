import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shineup/core/di/service_locator.dart';
import 'package:shineup/core/localization/app_localizations.dart';
import 'package:shineup/core/routes/app_pages.dart';
import 'package:shineup/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shineup/features/auth/presentation/widgets/auth_input_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        authRepository: sl(),
        initialMode: AuthMode.login,
      ),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.successMessage != null) {
          final permission = await Geolocator.checkPermission();
          if (!context.mounted) return;
          final locationGranted = permission == LocationPermission.whileInUse ||
              permission == LocationPermission.always;
          if (!locationGranted) {
            Navigator.of(context).pushReplacementNamed(
              AppRouter.locationAccess,
              arguments: {'redirectRoute': AppRouter.main},
            );
          } else {
            Navigator.of(context).pushReplacementNamed(AppRouter.main);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFFAF8FF),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ── Header Section ───────────────────────────────────
                        Container(
                          height: 192,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2563EB),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(32),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Opacity(
                                  opacity: 0.4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(32),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white.withValues(alpha: 0.15),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/app_icon.jpg',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, _, _) =>
                                            const SizedBox(
                                              width: 100,
                                              height: 100,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      t.appTitle,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                        letterSpacing: -0.6,
                                        color: Color(0xFFEEEFFF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ── Form Section ─────────────────────────────────────
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                t.welcomeBack,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Color(0xFF191B23),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                t.signInSubtitle,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xFF434655),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Login Method Toggle
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3F3FE),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => context
                                            .read<AuthBloc>()
                                            .add(const LoginMethodChanged(LoginMethod.phone)),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                            color: state.loginMethod == LoginMethod.phone
                                                ? Colors.white
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: state.loginMethod == LoginMethod.phone
                                                ? const [
                                                    BoxShadow(
                                                      color: Color(0x0D000000),
                                                      blurRadius: 4,
                                                      offset: Offset(0, 2),
                                                    ),
                                                  ]
                                                : null,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.phone_outlined,
                                                size: 16,
                                                color: state.loginMethod == LoginMethod.phone
                                                    ? const Color(0xFF2563EB)
                                                    : const Color(0xFF737686),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                t.loginWithPhone,
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: state.loginMethod == LoginMethod.phone
                                                      ? const Color(0xFF2563EB)
                                                      : const Color(0xFF737686),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => context
                                            .read<AuthBloc>()
                                            .add(const LoginMethodChanged(LoginMethod.email)),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                            color: state.loginMethod == LoginMethod.email
                                                ? Colors.white
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: state.loginMethod == LoginMethod.email
                                                ? const [
                                                    BoxShadow(
                                                      color: Color(0x0D000000),
                                                      blurRadius: 4,
                                                      offset: Offset(0, 2),
                                                    ),
                                                  ]
                                                : null,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.email_outlined,
                                                size: 16,
                                                color: state.loginMethod == LoginMethod.email
                                                    ? const Color(0xFF2563EB)
                                                    : const Color(0xFF737686),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                t.loginWithEmail,
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: state.loginMethod == LoginMethod.email
                                                      ? const Color(0xFF2563EB)
                                                      : const Color(0xFF737686),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Dynamic field: Phone or Email
                              if (state.loginMethod == LoginMethod.phone)
                                AuthInputField(
                                  label: t.phoneLabel,
                                  hintText: t.phoneHint,
                                  prefixIconWidget: const Icon(
                                    Icons.phone_outlined,
                                    size: 20,
                                    color: Color(0xFF737686),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  onChanged: (v) => context
                                      .read<AuthBloc>()
                                      .add(PhoneChanged(v)),
                                )
                              else
                                AuthInputField(
                                  label: t.emailLabel,
                                  hintText: t.emailHint,
                                  prefixIconWidget: const Icon(
                                    Icons.email_outlined,
                                    size: 20,
                                    color: Color(0xFF737686),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (v) => context
                                      .read<AuthBloc>()
                                      .add(EmailChanged(v)),
                                ),
                              const SizedBox(height: 16),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          t.passwordLabel,
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            letterSpacing: 0.6,
                                            color: Color(0xFF434655),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: TextButton(
                                        onPressed: () => Navigator.of(context)
                                            .pushNamed(
                                                AppRouter.forgotPassword),
                                        child: Text(
                                          t.forgotPassword,
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Color(0xFF2563EB),
                                          ),
                                        ),
                                      ),
                                      )
                                    ],
                                  ),
                                  AuthInputField(
                                    label: '',
                                    hintText: '••••••••',
                                    prefixIconWidget: const Icon(
                                      Icons.lock_outline,
                                      size: 20,
                                      color: Color(0xFF737686),
                                    ),
                                    obscureText: !state.showPassword,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        state.showPassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        size: 22,
                                        color: const Color(0xFF737686),
                                      ),
                                      onPressed: () => context
                                          .read<AuthBloc>()
                                          .add(TogglePasswordVisibility()),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 22,
                                        minHeight: 22,
                                      ),
                                    ),
                                    onChanged: (v) => context
                                        .read<AuthBloc>()
                                        .add(PasswordChanged(v)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              if (state.errorMessage != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    state.errorMessage!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),

                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(                                      onPressed: state.isLoading
                                          ? null
                                          : () {
                                              final platform = Theme.of(context).platform;
                                              final deviceType = switch (platform) {
                                                TargetPlatform.iOS => 'IOS',
                                                TargetPlatform.android => 'ANDROID',
                                                TargetPlatform.macOS => 'MACOS',
                                                _ => 'ANDROID',
                                              };
                                              context
                                                  .read<AuthBloc>()
                                                  .add(LoginSubmitted(deviceType: deviceType));
                                            },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2563EB),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(9999),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: state.isLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              t.login,
                                              style: const TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Icon(
                                              Icons.arrow_forward,
                                              size: 12,
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Divider
                              Row(
                                children: [
                                  const Expanded(
                                    child: Divider(
                                      color: Color(0xFFC3C6D7),
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      t.orContinueWith,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        letterSpacing: 0.6,
                                        color: Color(0xFF737686),
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Divider(
                                      color: Color(0xFFC3C6D7),
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Social Buttons
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     AuthSocialButton(
                              //       text: t.google,
                              //       icon: Icons.g_mobiledata,
                              //       iconColor: const Color(0xFFEA4335),
                              //     ),
                              //     const SizedBox(width: 12),
                              //     AuthSocialButton(
                              //       text: t.apple,
                              //       icon: Icons.apple,
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),

                        // ── Footer Toggle ────────────────────────────────────
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(32),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  t.noAccount,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xFF434655),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .pushReplacementNamed(AppRouter.register),
                                child: Text(
                                  t.signUp,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color(0xFF004AC6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
