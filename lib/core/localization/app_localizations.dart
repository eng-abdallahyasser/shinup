import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  /// Convenience — gets the locale from the nearest [Localizations] widget.
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations(Localizations.localeOf(context));
  }

  static const Map<String, Map<String, String>> _strings = {
    'en': {
      'appTitle': 'Shinup',
      'counterTitle': 'Counter',
      'counterDescription': 'You have pushed the button this many times:',
      'increment': 'Increment',
      // Auth - Login
      'welcomeBack': 'Welcome back',
      'signInSubtitle': 'Sign in to manage your vehicle repairs and services.',
      'loginWithPhone': 'Phone',
      'loginWithEmail': 'Email',
      'phoneLabel': 'PHONE NUMBER',
      'phoneHint': '+1 (555) 000-0000',
      'passwordLabel': 'PASSWORD',
      'forgotPassword': 'Forgot Password?',
      'login': 'Login',
      'orContinueWith': 'OR CONTINUE WITH',
      'noAccount': "Don't have an account? ",
      'signUp': 'Sign up',
      // Auth - Register
      'createAccount': 'Create Account',
      'registerSubtitle':
          'Create an account to start managing your vehicles and services.',
      'fullNameLabel': 'FULL NAME',
      'fullNameHint': 'John Doe',
      'registerButton': 'Sign Up',
      'orSignUpWith': 'Or sign up with',
      'termsText':
          'I agree to the Terms & Conditions and Privacy Policy',
      'hasAccount': 'Already have an account? ',
      'loginLink': 'Login',
      // Auth - OTP
      'otpTitle': 'Verify Phone Number',
      'otpSubtitle': 'Enter the 6-digit code sent to your phone',
      'verifyButton': 'Verify',
      'otpResend': "Didn't receive the code? Resend",
      // Auth - Forgot Password
      'forgotPasswordTitle': 'Forgot Password',
      'forgotPasswordSubtitle':
          'Enter your phone number to receive a reset code',
      'sendCodeButton': 'Send Code',
      // Auth - Reset Password
      'resetPasswordTitle': 'Reset Password',
      'resetPasswordSubtitle': 'Enter the code and your new password',
      'resetCodeLabel': 'RESET CODE',
      'resetCodeHint': '123456',
      'newPasswordLabel': 'NEW PASSWORD',
      'resetPasswordButton': 'Reset Password',
      'backToLogin': 'Back to Login',
      // Social
      'google': 'Google',
      'apple': 'Apple',
      'facebook': 'Facebook',
      // Navigation
      'navHome': 'Home',
      'navExplore': 'Explore',
      'navBookings': 'Bookings',
      'navFavorites': 'Favorites',
      'navProfile': 'Profile',
      // Onboarding
      'onboardingSkip': 'Skip',
      'onboardingNext': 'Next',
      'onboardingGetStarted': 'Get Started',
      'trustSupport': '24/7 Support',
      'trustExpress': 'Express',
      'trustQuality': 'Guaranteed',
      // Errors
      'errorFillAll': 'Please fill in all fields',
      'errorPhone': 'Please enter your phone number',
      'errorPassword': 'Please enter your password',
      'errorTerms': 'Please accept the terms and conditions',
    },
    'ar': {
      'appTitle': 'Shinup',
      'counterTitle': 'عداد',
      'counterDescription': 'لقد ضغطت على الزر هذا العدد من المرات:',
      'increment': 'زيادة',
      // Auth - Login
      'welcomeBack': 'مرحباً بعودتك',
      'signInSubtitle': 'سجل الدخول لإدارة إصلاحات وخدمات سيارتك.',
      'loginWithPhone': 'هاتف',
      'loginWithEmail': 'بريد إلكتروني',
      'phoneLabel': 'رقم الهاتف',
      'phoneHint': '+1 (555) 000-0000',
      'passwordLabel': 'كلمة المرور',
      'forgotPassword': 'نسيت كلمة المرور؟',
      'login': 'تسجيل الدخول',
      'orContinueWith': 'أو الاستمرار عبر',
      'noAccount': 'ليس لديك حساب؟ ',
      'signUp': 'اشتراك',
      // Auth - Register
      'createAccount': 'إنشاء حساب',
      'registerSubtitle': 'أنشئ حساباً لبدء إدارة سياراتك وخدماتك.',
      'fullNameLabel': 'الاسم الكامل',
      'fullNameHint': 'جون دو',
      'registerButton': 'اشتراك',
      'orSignUpWith': 'أو الاشتراك عبر',
      'termsText': 'أوافق على الشروط والأحكام وسياسة الخصوصية',
      'hasAccount': 'لديك حساب بالفعل؟ ',
      'loginLink': 'تسجيل الدخول',
      // Auth - OTP
      'otpTitle': 'تحقق من رقم الهاتف',
      'otpSubtitle': 'أدخل الرمز المكون من 6 أرقام المرسل إلى هاتفك',
      'verifyButton': 'تحقق',
      'otpResend': 'لم تستلم الرمز؟ إعادة إرسال',
      // Auth - Forgot Password
      'forgotPasswordTitle': 'نسيت كلمة المرور',
      'forgotPasswordSubtitle': 'أدخل رقم هاتفك لاستلام رمز إعادة التعيين',
      'sendCodeButton': 'إرسال الرمز',
      // Auth - Reset Password
      'resetPasswordTitle': 'إعادة تعيين كلمة المرور',
      'resetPasswordSubtitle': 'أدخل الرمز وكلمة المرور الجديدة',
      'resetCodeLabel': 'رمز إعادة التعيين',
      'resetCodeHint': '123456',
      'newPasswordLabel': 'كلمة المرور الجديدة',
      'resetPasswordButton': 'إعادة تعيين',
      'backToLogin': 'العودة إلى تسجيل الدخول',
      // Social
      'google': 'جوجل',
      'apple': 'أبل',
      'facebook': 'فيسبوك',
      // Navigation
      'navHome': 'الرئيسية',
      'navExplore': 'استكشاف',
      'navBookings': 'الحجوزات',
      'navFavorites': 'المفضلة',
      'navProfile': 'الملف الشخصي',
      // Onboarding
      'onboardingSkip': 'تخطي',
      'onboardingNext': 'التالي',
      'onboardingGetStarted': 'ابدأ',
      'trustSupport': 'دعم 24/7',
      'trustExpress': 'سريع',
      'trustQuality': 'مضمون',
      // Errors
      'errorFillAll': 'يرجى ملء جميع الحقول',
      'errorPhone': 'يرجى إدخال رقم هاتفك',
      'errorPassword': 'يرجى إدخال كلمة المرور',
      'errorTerms': 'يرجى الموافقة على الشروط والأحكام',
    },
  };

  String translate(String key) {
    return _strings[locale.languageCode]?[key] ?? _strings['ar']?[key] ?? key;
  }

  /// Localizes a number so Arabic users see Arabic-Indic digits (٠١٢٣…).
  String formatNumber(num value) {
    if (locale.languageCode == 'ar') {
      const arabicIndic = '٠١٢٣٤٥٦٧٨٩';
      return value
          .toString()
          .split('')
          .map((c) {
            final code = c.codeUnitAt(0);
            if (code >= 48 && code <= 57) {
              return arabicIndic[code - 48];
            }
            return c;
          })
          .join();
    }
    return value.toString();
  }

  // ── Convenience getters ──────────────────────────────────────────────────

  String get loginWithPhone => translate('loginWithPhone');
  String get loginWithEmail => translate('loginWithEmail');
  String get appTitle => translate('appTitle');
  String get counterTitle => translate('counterTitle');
  String get counterDescription => translate('counterDescription');
  String get increment => translate('increment');
  String get welcomeBack => translate('welcomeBack');
  String get signInSubtitle => translate('signInSubtitle');
  String get phoneLabel => translate('phoneLabel');
  String get phoneHint => translate('phoneHint');
  String get passwordLabel => translate('passwordLabel');
  String get forgotPassword => translate('forgotPassword');
  String get login => translate('login');
  String get orContinueWith => translate('orContinueWith');
  String get noAccount => translate('noAccount');
  String get signUp => translate('signUp');
  String get createAccount => translate('createAccount');
  String get registerSubtitle => translate('registerSubtitle');
  String get fullNameLabel => translate('fullNameLabel');
  String get fullNameHint => translate('fullNameHint');
  String get emailLabel => translate('emailLabel');
  String get emailHint => translate('emailHint');
  String get registerButton => translate('registerButton');
  String get orSignUpWith => translate('orSignUpWith');
  String get termsText => translate('termsText');
  String get hasAccount => translate('hasAccount');
  String get loginLink => translate('loginLink');
  String get otpTitle => translate('otpTitle');
  String get otpSubtitle => translate('otpSubtitle');
  String get verifyButton => translate('verifyButton');
  String get otpResend => translate('otpResend');
  String get forgotPasswordTitle => translate('forgotPasswordTitle');
  String get forgotPasswordSubtitle => translate('forgotPasswordSubtitle');
  String get sendCodeButton => translate('sendCodeButton');
  String get resetPasswordTitle => translate('resetPasswordTitle');
  String get resetPasswordSubtitle => translate('resetPasswordSubtitle');
  String get resetCodeLabel => translate('resetCodeLabel');
  String get resetCodeHint => translate('resetCodeHint');
  String get newPasswordLabel => translate('newPasswordLabel');
  String get resetPasswordButton => translate('resetPasswordButton');
  String get backToLogin => translate('backToLogin');
  String get google => translate('google');
  String get apple => translate('apple');
  String get facebook => translate('facebook');
  String get navHome => translate('navHome');
  String get navExplore => translate('navExplore');
  String get navBookings => translate('navBookings');
  String get navFavorites => translate('navFavorites');
  String get navProfile => translate('navProfile');
  String get onboardingSkip => translate('onboardingSkip');
  String get onboardingNext => translate('onboardingNext');
  String get onboardingGetStarted => translate('onboardingGetStarted');
  String get trustSupport => translate('trustSupport');
  String get trustExpress => translate('trustExpress');
  String get trustQuality => translate('trustQuality');
  String get errorFillAll => translate('errorFillAll');
  String get errorPhone => translate('errorPhone');
  String get errorPassword => translate('errorPassword');
  String get errorTerms => translate('errorTerms');
}
