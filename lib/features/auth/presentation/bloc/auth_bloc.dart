import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shineup/core/network/api_client.dart';
import 'package:shineup/features/auth/domain/repositories/auth_repository.dart';

// ── Auth Mode ───────────────────────────────────────────────────────────────

enum AuthMode { login, register }

enum LoginMethod { phone, email }

// ── Events ──────────────────────────────────────────────────────────────────

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class PhoneChanged extends AuthEvent {
  final String phone;
  const PhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

final class PasswordChanged extends AuthEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

final class NameChanged extends AuthEvent {
  final String name;
  const NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

final class LoginMethodChanged extends AuthEvent {
  final LoginMethod method;
  const LoginMethodChanged(this.method);

  @override
  List<Object?> get props => [method];
}

final class EmailChanged extends AuthEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

final class TogglePasswordVisibility extends AuthEvent {
  const TogglePasswordVisibility();
}

final class ToggleTermsAccepted extends AuthEvent {
  const ToggleTermsAccepted();
}

final class LoginSubmitted extends AuthEvent {
  final String deviceType;
  final String deviceToken;
  const LoginSubmitted({this.deviceType = 'ANDROID', this.deviceToken = ''});

  @override
  List<Object?> get props => [deviceType, deviceToken];
}

final class RegisterSubmitted extends AuthEvent {
  const RegisterSubmitted();
}

final class OtpCodeChanged extends AuthEvent {
  final String code;
  const OtpCodeChanged(this.code);

  @override
  List<Object?> get props => [code];
}

final class OtpSubmitted extends AuthEvent {
  const OtpSubmitted();
}

final class ForgotPasswordSubmitted extends AuthEvent {
  const ForgotPasswordSubmitted();
}

final class ResetPasswordSubmitted extends AuthEvent {
  const ResetPasswordSubmitted();
}

final class NewPasswordChanged extends AuthEvent {
  final String newPassword;
  const NewPasswordChanged(this.newPassword);

  @override
  List<Object?> get props => [newPassword];
}

final class ResetCodeChanged extends AuthEvent {
  final String code;
  const ResetCodeChanged(this.code);

  @override
  List<Object?> get props => [code];
}



// ── States ──────────────────────────────────────────────────────────────────

sealed class AuthState extends Equatable {
  final AuthMode mode;
  final LoginMethod loginMethod;
  final String phone;
  final String email;
  final String password;
  final String name;
  final bool showPassword;
  final bool termsAccepted;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  // OTP / Reset
  final String otpCode;
  final String userId;
  final String newPassword;
  final String resetCode;
  final String accountType;

  const AuthState({
    required this.mode,
    this.loginMethod = LoginMethod.phone,
    this.phone = '',
    this.email = '',
    this.password = '',
    this.name = '',
    this.showPassword = false,
    this.termsAccepted = false,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.otpCode = '',
    this.userId = '',
    this.newPassword = '',
    this.resetCode = '',
    this.accountType = 'customer',
  });

  @override
  List<Object?> get props => [
        mode,
        loginMethod,
        phone,
        email,
        password,
        name,
        showPassword,
        termsAccepted,
        isLoading,
        errorMessage,
        successMessage,
        otpCode,
        userId,
        newPassword,
        resetCode,
        accountType,
      ];
}

final class AuthInitial extends AuthState {
  const AuthInitial({
    required super.mode,
    super.loginMethod,
    super.phone,
    super.email,
    super.password,
    super.name,
    super.showPassword,
    super.termsAccepted,
    super.isLoading,
    super.errorMessage,
    super.successMessage,
    super.otpCode,
    super.userId,
    super.newPassword,
    super.resetCode,
    super.accountType,
  });
}

// ── Bloc ────────────────────────────────────────────────────────────────────

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({
    required AuthRepository authRepository,
    AuthMode initialMode = AuthMode.login,
    String initialUserId = '',
  }) : _authRepository = authRepository,
       super(AuthInitial(mode: initialMode, userId: initialUserId)) {
    on<PhoneChanged>(_onPhoneChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<NameChanged>(_onNameChanged);
    on<LoginMethodChanged>(_onLoginMethodChanged);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<ToggleTermsAccepted>(_onToggleTermsAccepted);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<OtpCodeChanged>(_onOtpCodeChanged);
    on<OtpSubmitted>(_onOtpSubmitted);
    on<ForgotPasswordSubmitted>(_onForgotPasswordSubmitted);
    on<ResetPasswordSubmitted>(_onResetPasswordSubmitted);
    on<NewPasswordChanged>(_onNewPasswordChanged);
    on<ResetCodeChanged>(_onResetCodeChanged);
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<AuthState> emit) {
    emit(_copy(state, phone: event.phone, errorMessage: null));
  }

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) {
    emit(_copy(state, email: event.email, errorMessage: null));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    emit(_copy(state, password: event.password, errorMessage: null));
  }

  void _onNameChanged(NameChanged event, Emitter<AuthState> emit) {
    if (state.mode == AuthMode.register) {
      emit(_copy(state, name: event.name, errorMessage: null));
    }
  }

  void _onLoginMethodChanged(
      LoginMethodChanged event, Emitter<AuthState> emit) {
    emit(_copy(state, loginMethod: event.method, errorMessage: null));
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<AuthState> emit) {
    emit(_copy(state, showPassword: !state.showPassword));
  }

  void _onToggleTermsAccepted(
      ToggleTermsAccepted event, Emitter<AuthState> emit) {
    if (state.mode == AuthMode.register) {
      emit(_copy(state, termsAccepted: !state.termsAccepted));
    }
  }

  void _onOtpCodeChanged(OtpCodeChanged event, Emitter<AuthState> emit) {
    emit(_copy(state, otpCode: event.code, errorMessage: null));
  }

  void _onNewPasswordChanged(
      NewPasswordChanged event, Emitter<AuthState> emit) {
    emit(_copy(state, newPassword: event.newPassword, errorMessage: null));
  }

  void _onResetCodeChanged(ResetCodeChanged event, Emitter<AuthState> emit) {
    emit(_copy(state, resetCode: event.code, errorMessage: null));
  }

  
  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<AuthState> emit) async {
    final identifier = state.loginMethod == LoginMethod.phone
        ? state.phone
        : state.email;
    if (identifier.isEmpty) {
      emit(_copy(
        state,
        errorMessage: state.loginMethod == LoginMethod.phone
            ? 'Please enter your phone number'
            : 'Please enter your email address',
      ));
      return;
    }
    if (state.password.isEmpty) {
      emit(_copy(state, errorMessage: 'Please enter your password'));
      return;
    }
    emit(_copy(state, isLoading: true, errorMessage: null));

    try {
      final response = await _authRepository.login(
        identifier: identifier,
        password: state.password,
        deviceType: event.deviceType,
        deviceToken: event.deviceToken,
      );

      if (response.token != null) {
        if (response.user != null) {
          await _authRepository.saveUserData(response.user!);
        }
        await _authRepository.saveToken(response.token!);
      }

      emit(_copy(
        state,
        isLoading: false,
        successMessage: 'Login successful!',
        userId: response.userId ?? '',
      ));
    } on ApiException catch (e) {
      emit(_copy(state, isLoading: false, errorMessage: e.message));
    } catch (e) {
      emit(_copy(
        state,
        isLoading: false,
        errorMessage: 'Connection failed. Please try again.',
      ));
    }
  }

  Future<void> _onRegisterSubmitted(
      RegisterSubmitted event, Emitter<AuthState> emit) async {
    if (state.name.isEmpty ||
        state.phone.isEmpty ||
        state.email.isEmpty ||
        state.password.isEmpty) {
      emit(_copy(state, errorMessage: 'Please fill in all fields'));
      return;
    }
    if (!state.termsAccepted) {
      emit(_copy(
        state,
        errorMessage: 'Please accept the terms and conditions',
      ));
      return;
    }
    emit(_copy(state, isLoading: true, errorMessage: null));

    try {
      final response = await _authRepository.register(
        fullName: state.name,
        phone: state.phone,
        email: state.email,
        password: state.password,
        accountType: state.accountType,
      );
      emit(_copy(
        state,
        isLoading: false,
        successMessage: 'Registration successful! Please verify your phone.',
        userId: response.userId ?? '',
      ));
    } on ApiException catch (e) {
      emit(_copy(state, isLoading: false, errorMessage: e.message));
    } catch (e) {
      emit(_copy(
        state,
        isLoading: false,
        errorMessage: 'Connection failed. Please try again.',
      ));
    }
  }

  Future<void> _onOtpSubmitted(
      OtpSubmitted event, Emitter<AuthState> emit) async {
    if (state.otpCode.isEmpty || state.otpCode.length < 4) {
      emit(_copy(state, errorMessage: 'Please enter a valid OTP code'));
      return;
    }
    emit(_copy(state, isLoading: true, errorMessage: null));

    try {
      final response = await _authRepository.verifyOtp(
        userId: state.userId,
        code: state.otpCode,
      );
      if (response.token != null) {
        await _authRepository.saveToken(response.token!);
      }
      emit(_copy(
        state,
        isLoading: false,
        successMessage: 'Phone verified successfully!',
      ));
    } on ApiException catch (e) {
      emit(_copy(state, isLoading: false, errorMessage: e.message));
    } catch (e) {
      emit(_copy(
        state,
        isLoading: false,
        errorMessage: 'Verification failed. Please try again.',
      ));
    }
  }

  Future<void> _onForgotPasswordSubmitted(
      ForgotPasswordSubmitted event, Emitter<AuthState> emit) async {
    if (state.phone.isEmpty) {
      emit(_copy(state, errorMessage: 'Please enter your phone number'));
      return;
    }
    emit(_copy(state, isLoading: true, errorMessage: null));

    try {
      await _authRepository.forgotPassword(identifier: state.phone);
      emit(_copy(
        state,
        isLoading: false,
        successMessage: 'Reset code sent to your phone!',
      ));
    } on ApiException catch (e) {
      emit(_copy(state, isLoading: false, errorMessage: e.message));
    } catch (e) {
      emit(_copy(
        state,
        isLoading: false,
        errorMessage: 'Failed to send reset code.',
      ));
    }
  }

  Future<void> _onResetPasswordSubmitted(
      ResetPasswordSubmitted event, Emitter<AuthState> emit) async {
    if (state.phone.isEmpty) {
      emit(_copy(state, errorMessage: 'Please enter your phone number'));
      return;
    }
    if (state.resetCode.isEmpty) {
      emit(_copy(state, errorMessage: 'Please enter the reset code'));
      return;
    }
    if (state.newPassword.isEmpty) {
      emit(_copy(state, errorMessage: 'Please enter a new password'));
      return;
    }
    emit(_copy(state, isLoading: true, errorMessage: null));

    try {
      await _authRepository.resetPassword(
        identifier: state.phone,
        code: state.resetCode,
        newPassword: state.newPassword,
      );
      emit(_copy(
        state,
        isLoading: false,
        successMessage: 'Password reset successfully!',
      ));
    } on ApiException catch (e) {
      emit(_copy(state, isLoading: false, errorMessage: e.message));
    } catch (e) {
      emit(_copy(
        state,
        isLoading: false,
        errorMessage: 'Failed to reset password.',
      ));
    }
  }

  AuthState _copy(AuthState s, {
    LoginMethod? loginMethod,
    String? phone,
    String? email,
    String? password,
    String? name,
    bool? showPassword,
    bool? termsAccepted,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    String? otpCode,
    String? userId,
    String? newPassword,
    String? resetCode,
    String? accountType,
  }) {
    return AuthInitial(
      mode: s.mode,
      loginMethod: loginMethod ?? s.loginMethod,
      phone: phone ?? s.phone,
      email: email ?? s.email,
      password: password ?? s.password,
      name: name ?? s.name,
      showPassword: showPassword ?? s.showPassword,
      termsAccepted: termsAccepted ?? s.termsAccepted,
      isLoading: isLoading ?? s.isLoading,
      errorMessage: errorMessage ?? s.errorMessage,
      successMessage: successMessage ?? s.successMessage,
      otpCode: otpCode ?? s.otpCode,
      userId: userId ?? s.userId,
      newPassword: newPassword ?? s.newPassword,
      resetCode: resetCode ?? s.resetCode,
      accountType: accountType ?? s.accountType,
    );
  }
}
