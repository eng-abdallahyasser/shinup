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
      'emailLabel': 'EMAIL',
      'emailHint': 'Enter your email',
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
      // Profile
      'profileTitle': 'Profile',
      'editProfile': 'Edit Profile',
      'addVehicleTitle': 'Add Vehicle',
      'carType': 'Car Type',
      'carBrand': 'Brand',
      'carModel': 'Model',
      'carYear': 'Year',
      'carColor': 'Color',
      'carPlate': 'Plate Number',
      'carDefault': 'Set as default vehicle',
      'addCarBtn': 'Add Vehicle',
      'selectCarType': 'Please select a car type',
      'enterBrand': 'Please enter the brand',
      'enterModel': 'Please enter the model',
      'enterYear': 'Please enter the year',
      'validYear': 'Please enter a valid year',
      'enterColor': 'Please enter the color',
      'enterPlate': 'Please enter the plate number',
      'failedCarTypes': 'Failed to load car types',
      'failedAddCar': 'Failed to add vehicle. Please try again.',
      'editVehicleTitle': 'Edit Vehicle',
      'failedLoadCar': 'Failed to load car details.',
      'failedUpdateCar': 'Failed to update vehicle. Please try again.',
      'failedSetDefault': 'Failed to set as default. Please try again.',
      'setAsDefault': 'Set as Default Vehicle',
      'setDefaultBtn': 'Set as Default',
      'setDefaultSubtitle': 'Make this your primary vehicle for bookings.',
      'defaultVehicleSubtitle': 'This is your default vehicle.',
      'defaultBadge': 'Default',
      'personalInfo': 'PERSONAL INFO',
      'fullName': 'FULL NAME',
      'emailAddress': 'EMAIL ADDRESS',
      'phoneNumber': 'PHONE NUMBER',
      'edit': 'Edit',
      'save': 'Save',
      'myVehicles': 'MY VEHICLES',
      'addVehicle': 'Add Vehicle',
      'noVehicles': 'No vehicles added yet. Tap + to add your first vehicle.',
      'loyaltyRewards': 'LOYALTY & REWARDS',
      'rewardsPoints': 'Rewards Points',
      'redeemYourPoints': 'Redeem your\nPoints',
      'recentActivity': 'RECENT ACTIVITY',
      'pointsEarned': 'Points Earned',
      'pointsUsed': 'Points Used',
      'accountSecurity': 'ACCOUNT SECURITY',
      'updatePassword': 'Update password',
      'currentPassword': 'Current password',
      'newPassword': 'New password',
      'updatePasswordBtn': 'Update Password',
      'activeSessions': 'ACTIVE SESSIONS',
      'current': 'Current',
      'ago': 'ago',
      'language': 'Language',
      'deleteAccount': 'Delete Account',
      'signOut': 'Sign Out',
      'version': 'Version',
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
      'emailLabel': 'البريد الإلكتروني',
      'emailHint': 'أدخل بريدك الإلكتروني',
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
      'navExplore': 'الخريطة',
      'navBookings': 'مواعيد',
      'navFavorites': 'المفضلة',
      'navProfile': ' ملفي',
      // Profile
      'profileTitle': 'الملف الشخصي',
      'editProfile': 'تعديل الملف',
      'addVehicleTitle': 'إضافة سيارة',
      'carType': 'نوع السيارة',
      'carBrand': 'العلامة التجارية',
      'carModel': 'الموديل',
      'carYear': 'السنة',
      'carColor': 'اللون',
      'carPlate': 'رقم اللوحة',
      'carDefault': 'تعيين كسيارة افتراضية',
      'addCarBtn': 'إضافة سيارة',
      'selectCarType': 'يرجى اختيار نوع السيارة',
      'enterBrand': 'يرجى إدخال العلامة التجارية',
      'enterModel': 'يرجى إدخال الموديل',
      'enterYear': 'يرجى إدخال السنة',
      'validYear': 'يرجى إدخال سنة صالحة',
      'enterColor': 'يرجى إدخال اللون',
      'enterPlate': 'يرجى إدخال رقم اللوحة',
      'failedCarTypes': 'فشل تحميل أنواع السيارات',
      'failedAddCar': 'فشل إضافة السيارة. حاول مرة أخرى.',
      'editVehicleTitle': 'تعديل السيارة',
      'failedLoadCar': 'فشل تحميل بيانات السيارة.',
      'failedUpdateCar': 'فشل تحديث السيارة. حاول مرة أخرى.',
      'failedSetDefault': 'فشل تعيين كسيارة افتراضية. حاول مرة أخرى.',
      'setAsDefault': 'تعيين كسيارة افتراضية',
      'setDefaultBtn': 'تعيين افتراضي',
      'setDefaultSubtitle': 'اجعل هذه سيارتك الأساسية للحجوزات.',
      'defaultVehicleSubtitle': 'هذه هي سيارتك الافتراضية.',
      'defaultBadge': 'افتراضي',
      'personalInfo': 'المعلومات الشخصية',
      'fullName': 'الاسم الكامل',
      'emailAddress': 'البريد الإلكتروني',
      'phoneNumber': 'رقم الهاتف',
      'edit': 'تعديل',
      'save': 'حفظ',
      'myVehicles': 'سياراتي',
      'addVehicle': 'إضافة سيارة',
      'noVehicles': 'لم تتم إضافة سيارات بعد. اضغط + لإضافة سيارتك الأولى.',
      'loyaltyRewards': 'المكافآت والولاء',
      'rewardsPoints': 'نقاط المكافآت',
      'redeemYourPoints': 'استبدال\nالنقاط',
      'recentActivity': 'آخر النشاطات',
      'pointsEarned': 'النقاط المكتسبة',
      'pointsUsed': 'النقاط المستخدمة',
      'accountSecurity': 'أمان الحساب',
      'updatePassword': 'تحديث كلمة المرور',
      'currentPassword': 'كلمة المرور الحالية',
      'newPassword': 'كلمة المرور الجديدة',
      'updatePasswordBtn': 'تحديث كلمة المرور',
      'activeSessions': 'الجلسات النشطة',
      'current': 'الحالية',
      'ago': 'منذ',
      'language': 'اللغة',
      'deleteAccount': 'حذف الحساب',
      'signOut': 'تسجيل الخروج',
      'version': 'الإصدار',
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
  String get profileTitle => translate('profileTitle');
  String get editProfile => translate('editProfile');
  String get addVehicleTitle => translate('addVehicleTitle');
  String get carType => translate('carType');
  String get carBrand => translate('carBrand');
  String get carModel => translate('carModel');
  String get carYear => translate('carYear');
  String get carColor => translate('carColor');
  String get carPlate => translate('carPlate');
  String get carDefault => translate('carDefault');
  String get addCarBtn => translate('addCarBtn');
  String get selectCarType => translate('selectCarType');
  String get enterBrand => translate('enterBrand');
  String get enterModel => translate('enterModel');
  String get enterYear => translate('enterYear');
  String get validYear => translate('validYear');
  String get enterColor => translate('enterColor');
  String get enterPlate => translate('enterPlate');
  String get failedCarTypes => translate('failedCarTypes');
  String get failedAddCar => translate('failedAddCar');
  String get editVehicleTitle => translate('editVehicleTitle');
  String get failedLoadCar => translate('failedLoadCar');
  String get failedUpdateCar => translate('failedUpdateCar');
  String get failedSetDefault => translate('failedSetDefault');
  String get setAsDefault => translate('setAsDefault');
  String get setDefaultBtn => translate('setDefaultBtn');
  String get setDefaultSubtitle => translate('setDefaultSubtitle');
  String get defaultVehicleSubtitle => translate('defaultVehicleSubtitle');
  String get defaultBadge => translate('defaultBadge');
  String get personalInfo => translate('personalInfo');
  String get fullName => translate('fullName');
  String get emailAddress => translate('emailAddress');
  String get phoneNumber => translate('phoneNumber');
  String get edit => translate('edit');
  String get save => translate('save');
  String get myVehicles => translate('myVehicles');
  String get addVehicle => translate('addVehicle');
  String get noVehicles => translate('noVehicles');
  String get loyaltyRewards => translate('loyaltyRewards');
  String get rewardsPoints => translate('rewardsPoints');
  String get redeemYourPoints => translate('redeemYourPoints');
  String get recentActivity => translate('recentActivity');
  String get pointsEarned => translate('pointsEarned');
  String get pointsUsed => translate('pointsUsed');
  String get accountSecurity => translate('accountSecurity');
  String get updatePassword => translate('updatePassword');
  String get currentPassword => translate('currentPassword');
  String get newPassword => translate('newPassword');
  String get updatePasswordBtn => translate('updatePasswordBtn');
  String get activeSessions => translate('activeSessions');
  String get current => translate('current');
  String get ago => translate('ago');
  String get language => translate('language');
  String get deleteAccount => translate('deleteAccount');
  String get signOut => translate('signOut');
  String get version => translate('version');
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
