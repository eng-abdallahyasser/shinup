import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinup/core/di/service_locator.dart';
import 'package:shinup/core/localization/app_localizations.dart';
import 'package:shinup/core/routes/app_pages.dart';
import 'package:shinup/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shinup/features/auth/presentation/widgets/auth_input_field.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        authRepository: sl(),
        initialMode: AuthMode.login,
      ),
      child: const _ResetPasswordView(),
    );
  }
}

class _ResetPasswordView extends StatelessWidget {
  const _ResetPasswordView();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          Navigator.of(context).pushReplacementNamed(AppRouter.login);
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
                    t.resetPasswordTitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color(0xFF191B23),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.resetPasswordSubtitle,
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
                  const SizedBox(height: 16),
                  AuthInputField(
                    label: t.resetCodeLabel,
                    hintText: t.resetCodeHint,
                    prefixIconWidget: const Icon(
                      Icons.pin_outlined,
                      size: 20,
                      color: Color(0xFF737686),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (v) =>
                        context.read<AuthBloc>().add(ResetCodeChanged(v)),
                  ),
                  const SizedBox(height: 16),
                  AuthInputField(
                    label: t.newPasswordLabel,
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
                    onChanged: (v) =>
                        context.read<AuthBloc>().add(NewPasswordChanged(v)),
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
                              .add(ResetPasswordSubmitted()),
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
                              t.resetPasswordButton,
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
