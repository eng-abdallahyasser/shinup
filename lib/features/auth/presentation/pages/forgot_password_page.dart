import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shineup/core/di/service_locator.dart';
import 'package:shineup/core/localization/app_localizations.dart';
import 'package:shineup/core/routes/app_pages.dart';
import 'package:shineup/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shineup/features/auth/presentation/widgets/auth_input_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        authRepository: sl(),
        initialMode: AuthMode.login,
      ),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatelessWidget {
  const _ForgotPasswordView();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          // Success — navigate to reset password page
          Navigator.of(context).pushNamed(AppRouter.resetPassword);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFFAF8FF),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF191B23)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    t.forgotPasswordTitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color(0xFF191B23),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.forgotPasswordSubtitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFF434655),
                    ),
                  ),
                  const SizedBox(height: 32),
                  AuthInputField(
                    label: t.phoneLabel,
                    hintText: t.phoneHint,
                    prefixIconWidget: const Icon(
                      Icons.phone_outlined,
                      size: 20,
                      color: Color(0xFF737686),
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (v) =>
                        context.read<AuthBloc>().add(PhoneChanged(v)),
                  ),
                  const SizedBox(height: 24),
                  if (state.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        state.errorMessage!,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (state.successMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        state.successMessage!,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () => context
                              .read<AuthBloc>()
                              .add(ForgotPasswordSubmitted()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004AC6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
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
                              t.sendCodeButton,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
