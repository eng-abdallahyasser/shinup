import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinup/core/di/service_locator.dart';
import 'package:shinup/core/localization/app_localizations.dart';
import 'package:shinup/core/routes/app_pages.dart';
import 'package:shinup/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shinup/features/auth/presentation/widgets/auth_input_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        authRepository: sl(),
        initialMode: AuthMode.register,
      ),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.successMessage != null && state.userId.isNotEmpty) {
          Navigator.of(context).pushReplacementNamed(
            AppRouter.otp,
            arguments: state.userId,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFFAF8FF),
          body: SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── Hero/Brand Section ───────────────────────────────
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 48),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2563EB),
                                borderRadius: BorderRadius.circular(32),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x0D000000),
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                'assets/app_icon.jpg',
                                width: 60,
                                height: 60,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              t.createAccount,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: Color(0xFF191B23),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              t.registerSubtitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xFF434655),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ── Registration Form ────────────────────────────────
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AuthInputField(
                              label: t.fullNameLabel,
                              hintText: t.fullNameHint,
                              prefixIconWidget: const Icon(
                                Icons.person_outline,
                                size: 20,
                                color: Color(0xFF737686),
                              ),
                              onChanged: (v) => context
                                  .read<AuthBloc>()
                                  .add(NameChanged(v)),
                            ),
                            const SizedBox(height: 16),
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
                            ),
                            const SizedBox(height: 16),
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
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return AuthInputField(
                                  label: t.passwordLabel,
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
                                );
                              },
                            ),
                            const SizedBox(height: 16),

                            // Terms & Conditions
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    value: state.termsAccepted,
                                    onChanged: (_) => context
                                        .read<AuthBloc>()
                                        .add(ToggleTermsAccepted()),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    side: const BorderSide(
                                      color: Color(0xFFC3C6D7),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: Text(
                                    t.termsText,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color(0xFF434655),
                                    ),
                                  ),
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
                              child: ElevatedButton(
                                onPressed: state.isLoading
                                    ? null
                                    : () => context
                                        .read<AuthBloc>()
                                        .add(RegisterSubmitted()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF004AC6),
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
                                    : Text(
                                        t.registerButton,
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Social Divider
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
                                      horizontal: 16),
                                  child: Text(
                                    t.orSignUpWith,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color(0xFFC3C6D7),
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
                            //       text: t.facebook,
                            //       icon: Icons.facebook,
                            //       iconColor: const Color(0xFF1877F2),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(height: 32),

                            // Login Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    t.hasAccount,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Color(0xFF434655),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushReplacementNamed(AppRouter.login),
                                  child: Text(
                                    t.loginLink,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Color(0xFF004AC6),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ],
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
