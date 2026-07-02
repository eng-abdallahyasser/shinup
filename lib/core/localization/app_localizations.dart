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
      'appTitle': 'Shineup',
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
      'deleteVehicle': 'Delete Vehicle',
      'deleteVehicleConfirm': 'Are you sure you want to delete this vehicle?',
      'deleteVehicleWarning': 'This action cannot be undone.',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'failedDeleteCar': 'Failed to delete vehicle. Please try again.',
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
      'myAddresses': 'MY ADDRESSES',
      'addAddress': 'Add Address',
      'noAddresses': 'No addresses added yet. Tap + to add your first address.',
      'addAddressTitle': 'Add Address',
      'addAddressBtn': 'Add Address',
      'addressTitle': 'TITLE',
      'enterAddressTitle': 'Please enter a title',
      'addressCity': 'CITY',
      'enterCity': 'Please enter the city',
      'addressArea': 'AREA',
      'enterArea': 'Please enter the area',
      'addressStreet': 'STREET',
      'enterStreet': 'Please enter the street',
      'addressBuilding': 'BUILDING NUMBER',
      'enterBuilding': 'Please enter the building number',
      'addressLatitude': 'LATITUDE',
      'enterLatitude': 'Please enter the latitude',
      'addressLongitude': 'LONGITUDE',
      'enterLongitude': 'Please enter the longitude',
      'addressNotes': 'NOTES (OPTIONAL)',
      'addressDefault': 'Set as default address',
      'editAddressTitle': 'Edit Address',
      'failedLoadAddress': 'Failed to load address details.',
      'failedAddAddress': 'Failed to add address. Please try again.',
      'failedUpdateAddress': 'Failed to update address. Please try again.',
      'failedSetDefaultAddress': 'Failed to set as default. Please try again.',
      'failedDeleteAddress': 'Failed to delete address. Please try again.',
      'deleteAddress': 'Delete Address',
      'deleteAddressConfirm': 'Are you sure you want to delete this address?',
      'deleteAddressWarning': 'This action cannot be undone.',
      'setAsDefaultAddress': 'Set as Default Address',
      'setDefaultAddressSubtitle': 'Make this your primary address for bookings.',
      'defaultAddressSubtitle': 'This is your default address.',
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
      // Location Permission
      'locationAccessTitle': 'Enable Location',
      'locationAccessSubtitle': 'Let Shineup find nearby services and repair shops for your vehicle.',
      'locationAccessTrustAccurate': 'Accurate',
      'locationAccessTrustFast': 'Fast',
      'locationAccessTrustReliable': 'Reliable',
      'locationAccessEnable': 'Enable Location',
      'locationAccessMaybeLater': 'Maybe Later',
      'locationAccessPrivacy': 'Your location is only used while using the app. We never share your data.',
      // Errors
      'errorFillAll': 'Please fill in all fields',
      'errorPhone': 'Please enter your phone number',
      'errorPassword': 'Please enter your password',
      'errorTerms': 'Please accept the terms and conditions',
      // Booking
      'bookingTitle': 'Book Service',
      'bookingSelection': 'Selection',
      'bookingDateAndTime': 'Date & Time',
      'bookingReview': 'Review',
      'bookingWash': 'Wash',
      'bookingAsap': 'ASAP',
      'bookingNearestAvailable': 'Nearest Available',
      'bookingSchedule': 'Schedule',
      'bookingPickDateAndTime': 'Pick Date & Time',
      'bookingInMinutes': 'In 30 minutes',
      'bookingSelectCar': 'Select Car',
      'bookingSelectAddress': 'Select Address',
      'bookingSelectDate': 'Select Date',
      'bookingAvailable': 'available',
      'bookingSelectTimeSlot': 'Select Time Slot',
      'bookingContinue': 'Continue',
      'bookingReviewAndConfirm': 'Review & Confirm',
      'bookingSelectionLabel': 'SELECTION',
      'bookingDateAndTimeLabel': 'DATE & TIME',
      'bookingReviewLabel': 'REVIEW',
      'bookingDetails': 'Booking Details',
      'bookingProvider': 'PROVIDER',
      'bookingDateAndTimeRow': 'DATE & TIME',
      'bookingAsapBadge': 'ASAP',
      'bookingServiceRow': 'SERVICE',
      'bookingNotes': 'Notes',
      'bookingNotesPlaceholder': 'Add special instructions for the provider...',
      'bookingPhotos': 'Photos',
      'bookingPhotosHint': 'Tap to add photos of your vehicle',
      'bookingServiceFee': 'Service Fee',
      'bookingFree': 'Free',
      'bookingTotal': 'Total',
      'bookingConfirm': 'Confirm Booking',
      'bookingDisclaimer': 'By confirming, you agree to our Terms of Service and Cancellation Policy.',
      'bookingFilterUpcoming': 'Upcoming',
      'bookingFilterPast': 'Past',
      'bookingFilterCancelled': 'Cancelled',
      'bookingNoBookings': 'No bookings found',
      'bookingEmptySubtitle': 'Your bookings will appear here',
      'bookingCancelTitle': 'Cancel Booking',
      'bookingCancelConfirm': 'Are you sure you want to cancel this booking?',
      'bookingCancelKeep': 'Keep Booking',
      'bookingCancelAction': 'Cancel Booking',
      'bookingCancelBtn': 'Cancel Booking',
      'bookingCancelledSuccess': 'Booking cancelled',
      'bookingFailedLoad': 'Failed to load bookings',
      'bookingFailedCancel': 'Failed to cancel booking',
      'bookingRetry': 'Retry',
      'bookingMyBookings': 'My Bookings',
      'bookingConfirmed': 'Booking confirmed!',
      'bookingFailedCreate': 'Failed to create booking',
      'bookingScheduled': 'Scheduled',
      'bookingCar': 'CAR',
      'bookingAddress': 'ADDRESS',
      'bookingInstructions': 'Instructions',
      'bookingInstructionsPlaceholder': 'Add instructions for the provider...',
      'bookingSomethingWrong': 'Something went wrong',
      'bookingMon': 'MON',
      'bookingTue': 'TUE',
      'bookingWed': 'WED',
      'bookingThu': 'THU',
      'bookingFri': 'FRI',
      'bookingSat': 'SAT',
      'bookingSun': 'SUN',
      'monthJan': 'Jan',
      'monthFeb': 'Feb',
      'monthMar': 'Mar',
      'monthApr': 'Apr',
      'monthMay': 'May',
      'monthJun': 'Jun',
      'monthJul': 'Jul',
      'monthAug': 'Aug',
      'monthSep': 'Sep',
      'monthOct': 'Oct',
      'monthNov': 'Nov',
      'monthDec': 'Dec',
      'dayMon': 'Mon',
      'dayTue': 'Tue',
      'dayWed': 'Wed',
      'dayThu': 'Thu',
      'dayFri': 'Fri',
      'daySat': 'Sat',
      'daySun': 'Sun',
      'timeAM': 'AM',
      'timePM': 'PM',
      'statusPending': 'Pending',
      'statusConfirmed': 'Confirmed',
      'statusInProgress': 'In Progress',
      'statusCompleted': 'Completed',
      'statusCancelled': 'Cancelled',
      // Home
      'homeAppBarTitle': 'Location',
      'homeHeroTitle': 'Book Trusted Car Care,\nRight Where You Are.',
      'homeSearchHint': 'What does your car need?',
      'homeFilterWash': 'Wash',
      'homeFilterRepair': 'Repair',
      'homeFilterTire': 'Tire',
      'homeRecommendedTitle': 'Recommended for you',
      'homeSeeAll': 'See all',
      'homeStatusOpen': 'OPEN',
      'homeStatusClosed': 'CLOSED',
      'homeUnitKm': 'km',
      'homeTagRepair': 'Repair',
      'homeTagTires': 'Tires',
      'homeTagCarWash': 'Car Wash',
      'homePromoLabel': 'PROMO',
      'homePromoTitle': '20% Off Your\nFirst Wash',
      'homeSupportLabel': 'SUPPORT',
      'homeSupportTitle': 'Expert Care\nAdvisor',
      // Explore
      'exploreServiceTitle': 'Full Exterior Polish\n& Wax',
      'exploreGetDirections': 'Get directions',
      // Provider Detail
      'providerTabServices': 'Services',
      'providerTabReviews': 'Reviews',
      'providerTabAbout': 'About',
      'providerUnitKmAway': 'km away',
      'providerActionCall': 'Call',
      'providerActionDirections': 'Directions',
      'providerActionShare': 'Share',
      'providerServiceGroupWashCare': 'Wash & Care',
      'providerServiceGroupRepairs': 'Repairs & Maintenance',
      'providerServiceAdd': 'Add',
      'providerServiceAdded': 'Added',
      'providerReviewsTitle': 'Customer Reviews',
      'providerRatingExcellent': 'Excellent',
      'providerRatingGood': 'Good',
      'providerRatingAverage': 'Average',
      'providerAboutTitle': 'About & Contact',
      'providerAboutHours': 'Operating Hours',
      'providerAboutHoursWeekdays': 'Mon\u2013Fri',
      'providerAboutHoursWeekdaysTime': '8:00 AM \u2013 6:00 PM',
      'providerAboutHoursWeekend': 'Sat\u2013Sun',
      'providerAboutHoursWeekendTime': '9:00 AM \u2013 4:00 PM',
      'providerAboutPhone': 'Phone',
      'providerAboutSpecializations': 'Specializations',
      'providerCtaTotal': 'TOTAL',
      'providerCtaBookNow': 'Book Now',
      'providerCtaServices': 'services',
      'providerCtaSelectServices': 'Select services',
    },
    'ar': {
      'appTitle': 'Shineup',
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
      'deleteVehicle': 'حذف السيارة',
      'deleteVehicleConfirm': 'هل أنت متأكد أنك تريد حذف هذه السيارة؟',
      'deleteVehicleWarning': 'لا يمكن التراجع عن هذا الإجراء.',
      'cancel': 'إلغاء',
      'delete': 'حذف',
      'failedDeleteCar': 'فشل حذف السيارة. حاول مرة أخرى.',
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
      'myAddresses': 'عناويني',
      'addAddress': 'إضافة عنوان',
      'noAddresses': 'لم تتم إضافة عناوين بعد. اضغط + لإضافة عنوانك الأول.',
      'addAddressTitle': 'إضافة عنوان',
      'addAddressBtn': 'إضافة عنوان',
      'addressTitle': 'العنوان',
      'enterAddressTitle': 'يرجى إدخال العنوان',
      'addressCity': 'المدينة',
      'enterCity': 'يرجى إدخال المدينة',
      'addressArea': 'المنطقة',
      'enterArea': 'يرجى إدخال المنطقة',
      'addressStreet': 'الشارع',
      'enterStreet': 'يرجى إدخال الشارع',
      'addressBuilding': 'رقم المبنى',
      'enterBuilding': 'يرجى إدخال رقم المبنى',
      'addressLatitude': 'خط العرض',
      'enterLatitude': 'يرجى إدخال خط العرض',
      'addressLongitude': 'خط الطول',
      'enterLongitude': 'يرجى إدخال خط الطول',
      'addressNotes': 'ملاحظات (اختياري)',
      'addressDefault': 'تعيين كعنوان افتراضي',
      'editAddressTitle': 'تعديل العنوان',
      'failedLoadAddress': 'فشل تحميل بيانات العنوان.',
      'failedAddAddress': 'فشل إضافة العنوان. حاول مرة أخرى.',
      'failedUpdateAddress': 'فشل تحديث العنوان. حاول مرة أخرى.',
      'failedSetDefaultAddress': 'فشل تعيين كعنوان افتراضي. حاول مرة أخرى.',
      'failedDeleteAddress': 'فشل حذف العنوان. حاول مرة أخرى.',
      'deleteAddress': 'حذف العنوان',
      'deleteAddressConfirm': 'هل أنت متأكد أنك تريد حذف هذا العنوان؟',
      'deleteAddressWarning': 'لا يمكن التراجع عن هذا الإجراء.',
      'setAsDefaultAddress': 'تعيين كعنوان افتراضي',
      'setDefaultAddressSubtitle': 'اجعل هذا عنوانك الأساسي للحجوزات.',
      'defaultAddressSubtitle': 'هذا هو عنوانك الافتراضي.',
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
      // Location Permission
      'locationAccessTitle': 'تفعيل الموقع',
      'locationAccessSubtitle': 'اسمح لـ Shineup بالعثور على الخدمات وورش الإصلاح القريبة من سيارتك.',
      'locationAccessTrustAccurate': 'دقيق',
      'locationAccessTrustFast': 'سريع',
      'locationAccessTrustReliable': 'موثوق',
      'locationAccessEnable': 'تفعيل الموقع',
      'locationAccessMaybeLater': 'لاحقاً',
      'locationAccessPrivacy': 'يتم استخدام موقعك فقط أثناء استخدام التطبيق. نحن لا نشارك بياناتك أبداً.',
      // Errors
      'errorFillAll': 'يرجى ملء جميع الحقول',
      'errorPhone': 'يرجى إدخال رقم هاتفك',
      'errorPassword': 'يرجى إدخال كلمة المرور',
      'errorTerms': 'يرجى الموافقة على الشروط والأحكام',
      // Booking
      'bookingTitle': 'حجز خدمة',
      'bookingSelection': 'اختيار',
      'bookingDateAndTime': 'التاريخ والوقت',
      'bookingReview': 'مراجعة',
      'bookingWash': 'غسيل',
      'bookingAsap': 'بأسرع وقت',
      'bookingNearestAvailable': 'الأقرب المتاح',
      'bookingSchedule': 'جدولة',
      'bookingPickDateAndTime': 'اختر التاريخ والوقت',
      'bookingInMinutes': 'خلال 30 دقيقة',
      'bookingSelectCar': 'اختر السيارة',
      'bookingSelectAddress': 'اختر العنوان',
      'bookingSelectDate': 'اختر التاريخ',
      'bookingAvailable': 'متاح',
      'bookingSelectTimeSlot': 'اختر الوقت',
      'bookingContinue': 'متابعة',
      'bookingReviewAndConfirm': 'مراجعة وتأكيد',
      'bookingSelectionLabel': 'اختيار',
      'bookingDateAndTimeLabel': 'تاريخ ووقت',
      'bookingReviewLabel': 'مراجعة',
      'bookingDetails': 'تفاصيل الحجز',
      'bookingProvider': 'مقدم الخدمة',
      'bookingDateAndTimeRow': 'التاريخ والوقت',
      'bookingAsapBadge': 'بأسرع وقت',
      'bookingServiceRow': 'الخدمة',
      'bookingNotes': 'ملاحظات',
      'bookingNotesPlaceholder': 'أضف تعليمات خاصة لمقدم الخدمة...',
      'bookingPhotos': 'صور',
      'bookingPhotosHint': 'انقر لإضافة صور لسيارتك',
      'bookingServiceFee': 'رسوم الخدمة',
      'bookingFree': 'مجاناً',
      'bookingTotal': 'الإجمالي',
      'bookingConfirm': 'تأكيد الحجز',
      'bookingDisclaimer': 'بالتأكيد، أنت توافق على شروط الخدمة وسياسة الإلغاء.',
      'bookingFilterUpcoming': 'القادمة',
      'bookingFilterPast': 'السابقة',
      'bookingFilterCancelled': 'ملغية',
      'bookingNoBookings': 'لا توجد حجوزات',
      'bookingEmptySubtitle': 'ستظهر حجوزاتك هنا',
      'bookingCancelTitle': 'إلغاء الحجز',
      'bookingCancelConfirm': 'هل أنت متأكد من إلغاء هذا الحجز؟',
      'bookingCancelKeep': 'الاحتفاظ بالحجز',
      'bookingCancelAction': 'إلغاء الحجز',
      'bookingCancelBtn': 'إلغاء الحجز',
      'bookingCancelledSuccess': 'تم إلغاء الحجز',
      'bookingFailedLoad': 'فشل تحميل الحجوزات',
      'bookingFailedCancel': 'فشل إلغاء الحجز',
      'bookingRetry': 'إعادة المحاولة',
      'bookingMyBookings': 'حجوزاتي',
      'bookingConfirmed': 'تم تأكيد الحجز!',
      'bookingFailedCreate': 'فشل إنشاء الحجز',
      'bookingScheduled': 'مجدول',
      'bookingCar': 'السيارة',
      'bookingAddress': 'العنوان',
      'bookingInstructions': 'تعليمات',
      'bookingInstructionsPlaceholder': 'أضف تعليمات لمقدم الخدمة...',
      'bookingSomethingWrong': 'حدث خطأ ما',
      'bookingMon': 'الإثنين',
      'bookingTue': 'الثلاثاء',
      'bookingWed': 'الأربعاء',
      'bookingThu': 'الخميس',
      'bookingFri': 'الجمعة',
      'bookingSat': 'السبت',
      'bookingSun': 'الأحد',
      'monthJan': 'يناير',
      'monthFeb': 'فبراير',
      'monthMar': 'مارس',
      'monthApr': 'أبريل',
      'monthMay': 'مايو',
      'monthJun': 'يونيو',
      'monthJul': 'يوليو',
      'monthAug': 'أغسطس',
      'monthSep': 'سبتمبر',
      'monthOct': 'أكتوبر',
      'monthNov': 'نوفمبر',
      'monthDec': 'ديسمبر',
      'dayMon': 'الإثنين',
      'dayTue': 'الثلاثاء',
      'dayWed': 'الأربعاء',
      'dayThu': 'الخميس',
      'dayFri': 'الجمعة',
      'daySat': 'السبت',
      'daySun': 'الأحد',
      'timeAM': 'ص',
      'timePM': 'م',
      'statusPending': 'قيد الانتظار',
      'statusConfirmed': 'مؤكد',
      'statusInProgress': 'قيد التنفيذ',
      'statusCompleted': 'مكتمل',
      'statusCancelled': 'ملغي',
      // Home
      'homeAppBarTitle': 'الموقع',
      'homeHeroTitle': 'احجز عناية موثوقة بسيارتك،\nأينما كنت.',
      'homeSearchHint': 'ماذا تحتاج سيارتك؟',
      'homeFilterWash': 'غسيل',
      'homeFilterRepair': 'إصلاح',
      'homeFilterTire': 'إطارات',
      'homeRecommendedTitle': 'موصى به لك',
      'homeSeeAll': 'عرض الكل',
      'homeStatusOpen': 'مفتوح',
      'homeStatusClosed': 'مغلق',
      'homeUnitKm': 'كم',
      'homeTagRepair': 'إصلاح',
      'homeTagTires': 'إطارات',
      'homeTagCarWash': 'غسيل سيارات',
      'homePromoLabel': 'عرض',
      'homePromoTitle': 'خصم 20%\nلأول غسلة',
      'homeSupportLabel': 'دعم',
      'homeSupportTitle': 'مستشار\nرعاية خبير',
      // Explore
      'exploreServiceTitle': 'تلميع خارجي كامل\nوشمع',
      'exploreGetDirections': 'الحصول على الاتجاهات',
      // Provider Detail
      'providerTabServices': 'الخدمات',
      'providerTabReviews': 'التقييمات',
      'providerTabAbout': 'حول',
      'providerUnitKmAway': 'كم',
      'providerActionCall': 'اتصال',
      'providerActionDirections': 'اتجاهات',
      'providerActionShare': 'مشاركة',
      'providerServiceGroupWashCare': 'غسيل وعناية',
      'providerServiceGroupRepairs': 'إصلاحات وصيانة',
      'providerServiceAdd': 'إضافة',
      'providerServiceAdded': 'تمت الإضافة',
      'providerReviewsTitle': 'تقييمات العملاء',
      'providerRatingExcellent': 'ممتاز',
      'providerRatingGood': 'جيد',
      'providerRatingAverage': 'متوسط',
      'providerAboutTitle': 'حول والاتصال',
      'providerAboutHours': 'ساعات العمل',
      'providerAboutHoursWeekdays': 'الإثنين–الجمعة',
      'providerAboutHoursWeekdaysTime': '٨:٠٠ ص – ٦:٠٠ م',
      'providerAboutHoursWeekend': 'السبت–الأحد',
      'providerAboutHoursWeekendTime': '٩:٠٠ ص – ٤:٠٠ م',
      'providerAboutPhone': 'الهاتف',
      'providerAboutSpecializations': 'التخصصات',
      'providerCtaTotal': 'المجموع',
      'providerCtaBookNow': 'احجز الآن',
      'providerCtaServices': 'خدمات',
      'providerCtaSelectServices': 'اختر الخدمات',
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
  String get deleteVehicle => translate('deleteVehicle');
  String get deleteVehicleConfirm => translate('deleteVehicleConfirm');
  String get deleteVehicleWarning => translate('deleteVehicleWarning');
  String get cancel => translate('cancel');
  String get delete => translate('delete');
  String get bookingFilterUpcoming => translate('bookingFilterUpcoming');
  String get bookingFilterPast => translate('bookingFilterPast');
  String get bookingFilterCancelled => translate('bookingFilterCancelled');
  String get bookingNoBookings => translate('bookingNoBookings');
  String get bookingEmptySubtitle => translate('bookingEmptySubtitle');
  String get bookingCancelTitle => translate('bookingCancelTitle');
  String get bookingCancelConfirm => translate('bookingCancelConfirm');
  String get bookingCancelKeep => translate('bookingCancelKeep');
  String get bookingCancelAction => translate('bookingCancelAction');
  String get bookingCancelBtn => translate('bookingCancelBtn');
  String get bookingCancelledSuccess => translate('bookingCancelledSuccess');
  String get bookingFailedLoad => translate('bookingFailedLoad');
  String get bookingFailedCancel => translate('bookingFailedCancel');
  String get bookingRetry => translate('bookingRetry');
  String get bookingMyBookings => translate('bookingMyBookings');
  String get failedDeleteCar => translate('failedDeleteCar');
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
  String get myAddresses => translate('myAddresses');
  String get addAddress => translate('addAddress');
  String get noAddresses => translate('noAddresses');
  String get addAddressTitle => translate('addAddressTitle');
  String get addAddressBtn => translate('addAddressBtn');
  String get addressTitle => translate('addressTitle');
  String get enterAddressTitle => translate('enterAddressTitle');
  String get addressCity => translate('addressCity');
  String get enterCity => translate('enterCity');
  String get addressArea => translate('addressArea');
  String get enterArea => translate('enterArea');
  String get addressStreet => translate('addressStreet');
  String get enterStreet => translate('enterStreet');
  String get addressBuilding => translate('addressBuilding');
  String get enterBuilding => translate('enterBuilding');
  String get addressLatitude => translate('addressLatitude');
  String get enterLatitude => translate('enterLatitude');
  String get addressLongitude => translate('addressLongitude');
  String get enterLongitude => translate('enterLongitude');
  String get addressNotes => translate('addressNotes');
  String get addressDefault => translate('addressDefault');
  String get editAddressTitle => translate('editAddressTitle');
  String get failedLoadAddress => translate('failedLoadAddress');
  String get failedAddAddress => translate('failedAddAddress');
  String get failedUpdateAddress => translate('failedUpdateAddress');
  String get failedSetDefaultAddress => translate('failedSetDefaultAddress');
  String get failedDeleteAddress => translate('failedDeleteAddress');
  String get deleteAddress => translate('deleteAddress');
  String get deleteAddressConfirm => translate('deleteAddressConfirm');
  String get deleteAddressWarning => translate('deleteAddressWarning');
  String get setAsDefaultAddress => translate('setAsDefaultAddress');
  String get setDefaultAddressSubtitle => translate('setDefaultAddressSubtitle');
  String get defaultAddressSubtitle => translate('defaultAddressSubtitle');
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
  String get locationAccessTitle => translate('locationAccessTitle');
  String get locationAccessSubtitle => translate('locationAccessSubtitle');
  String get locationAccessTrustAccurate => translate('locationAccessTrustAccurate');
  String get locationAccessTrustFast => translate('locationAccessTrustFast');
  String get locationAccessTrustReliable => translate('locationAccessTrustReliable');
  String get locationAccessEnable => translate('locationAccessEnable');
  String get locationAccessMaybeLater => translate('locationAccessMaybeLater');
  String get locationAccessPrivacy => translate('locationAccessPrivacy');

  // Booking
  String get bookingTitle => translate('bookingTitle');
  String get bookingSelection => translate('bookingSelection');
  String get bookingDateAndTime => translate('bookingDateAndTime');
  String get bookingReview => translate('bookingReview');
  String get bookingWash => translate('bookingWash');
  String get bookingAsap => translate('bookingAsap');
  String get bookingNearestAvailable => translate('bookingNearestAvailable');
  String get bookingSchedule => translate('bookingSchedule');
  String get bookingPickDateAndTime => translate('bookingPickDateAndTime');
  String get bookingInMinutes => translate('bookingInMinutes');
  String get bookingSelectCar => translate('bookingSelectCar');
  String get bookingSelectAddress => translate('bookingSelectAddress');
  String get bookingSelectDate => translate('bookingSelectDate');
  String get bookingAvailable => translate('bookingAvailable');
  String get bookingSelectTimeSlot => translate('bookingSelectTimeSlot');
  String get bookingContinue => translate('bookingContinue');
  String get bookingReviewAndConfirm => translate('bookingReviewAndConfirm');
  String get bookingSelectionLabel => translate('bookingSelectionLabel');
  String get bookingDateAndTimeLabel => translate('bookingDateAndTimeLabel');
  String get bookingReviewLabel => translate('bookingReviewLabel');
  String get bookingDetails => translate('bookingDetails');
  String get bookingProvider => translate('bookingProvider');
  String get bookingDateAndTimeRow => translate('bookingDateAndTimeRow');
  String get bookingAsapBadge => translate('bookingAsapBadge');
  String get bookingServiceRow => translate('bookingServiceRow');
  String get bookingNotes => translate('bookingNotes');
  String get bookingNotesPlaceholder => translate('bookingNotesPlaceholder');
  String get bookingPhotos => translate('bookingPhotos');
  String get bookingPhotosHint => translate('bookingPhotosHint');
  String get bookingServiceFee => translate('bookingServiceFee');
  String get bookingFree => translate('bookingFree');
  String get bookingTotal => translate('bookingTotal');
  String get bookingConfirm => translate('bookingConfirm');
  String get bookingDisclaimer => translate('bookingDisclaimer');
  String get bookingConfirmed => translate('bookingConfirmed');
  String get bookingFailedCreate => translate('bookingFailedCreate');
  String get bookingScheduled => translate('bookingScheduled');
  String get bookingCar => translate('bookingCar');
  String get bookingAddress => translate('bookingAddress');
  String get bookingInstructions => translate('bookingInstructions');
  String get bookingInstructionsPlaceholder =>
      translate('bookingInstructionsPlaceholder');
  String get bookingSomethingWrong => translate('bookingSomethingWrong');
  String get bookingMon => translate('bookingMon');
  String get bookingTue => translate('bookingTue');
  String get bookingWed => translate('bookingWed');
  String get bookingThu => translate('bookingThu');
  String get bookingFri => translate('bookingFri');
  String get bookingSat => translate('bookingSat');
  String get bookingSun => translate('bookingSun');
  List<String> get months => [
        translate('monthJan'),
        translate('monthFeb'),
        translate('monthMar'),
        translate('monthApr'),
        translate('monthMay'),
        translate('monthJun'),
        translate('monthJul'),
        translate('monthAug'),
        translate('monthSep'),
        translate('monthOct'),
        translate('monthNov'),
        translate('monthDec'),
      ];
  List<String> get days => [
        translate('dayMon'),
        translate('dayTue'),
        translate('dayWed'),
        translate('dayThu'),
        translate('dayFri'),
        translate('daySat'),
        translate('daySun'),
      ];
  String get timeAM => translate('timeAM');
  String get timePM => translate('timePM');
  String get statusPending => translate('statusPending');
  String get statusConfirmed => translate('statusConfirmed');
  String get statusInProgress => translate('statusInProgress');
  String get statusCompleted => translate('statusCompleted');
  String get statusCancelled => translate('statusCancelled');

  // Home
  String get homeAppBarTitle => translate('homeAppBarTitle');
  String get homeHeroTitle => translate('homeHeroTitle');
  String get homeSearchHint => translate('homeSearchHint');
  String get homeFilterWash => translate('homeFilterWash');
  String get homeFilterRepair => translate('homeFilterRepair');
  String get homeFilterTire => translate('homeFilterTire');
  String get homeRecommendedTitle => translate('homeRecommendedTitle');
  String get homeSeeAll => translate('homeSeeAll');
  String get homeStatusOpen => translate('homeStatusOpen');
  String get homeStatusClosed => translate('homeStatusClosed');
  String get homeUnitKm => translate('homeUnitKm');
  String get homeTagRepair => translate('homeTagRepair');
  String get homeTagTires => translate('homeTagTires');
  String get homeTagCarWash => translate('homeTagCarWash');
  String get homePromoLabel => translate('homePromoLabel');
  String get homePromoTitle => translate('homePromoTitle');
  String get homeSupportLabel => translate('homeSupportLabel');
  String get homeSupportTitle => translate('homeSupportTitle');

  // Explore
  String get exploreServiceTitle => translate('exploreServiceTitle');
  String get exploreGetDirections => translate('exploreGetDirections');

  // Provider Detail
  String get providerTabServices => translate('providerTabServices');
  String get providerTabReviews => translate('providerTabReviews');
  String get providerTabAbout => translate('providerTabAbout');
  String get providerUnitKmAway => translate('providerUnitKmAway');
  String get providerActionCall => translate('providerActionCall');
  String get providerActionDirections => translate('providerActionDirections');
  String get providerActionShare => translate('providerActionShare');
  String get providerServiceGroupWashCare => translate('providerServiceGroupWashCare');
  String get providerServiceGroupRepairs => translate('providerServiceGroupRepairs');
  String get providerServiceAdd => translate('providerServiceAdd');
  String get providerServiceAdded => translate('providerServiceAdded');
  String get providerReviewsTitle => translate('providerReviewsTitle');
  String get providerRatingExcellent => translate('providerRatingExcellent');
  String get providerRatingGood => translate('providerRatingGood');
  String get providerRatingAverage => translate('providerRatingAverage');
  String get providerAboutTitle => translate('providerAboutTitle');
  String get providerAboutHours => translate('providerAboutHours');
  String get providerAboutHoursWeekdays => translate('providerAboutHoursWeekdays');
  String get providerAboutHoursWeekdaysTime => translate('providerAboutHoursWeekdaysTime');
  String get providerAboutHoursWeekend => translate('providerAboutHoursWeekend');
  String get providerAboutHoursWeekendTime => translate('providerAboutHoursWeekendTime');
  String get providerAboutPhone => translate('providerAboutPhone');
  String get providerAboutSpecializations => translate('providerAboutSpecializations');
  String get providerCtaTotal => translate('providerCtaTotal');
  String get providerCtaBookNow => translate('providerCtaBookNow');
  String get providerCtaServices => translate('providerCtaServices');
  String get providerCtaSelectServices => translate('providerCtaSelectServices');

  String get errorFillAll => translate('errorFillAll');
  String get errorPhone => translate('errorPhone');
  String get errorPassword => translate('errorPassword');
  String get errorTerms => translate('errorTerms');
}
