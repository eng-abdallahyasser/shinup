import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinup/core/di/service_locator.dart';
import 'package:shinup/core/localization/locale_cubit.dart';
import 'package:shinup/core/routes/app_pages.dart';
import 'package:shinup/core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A minimal asset bundle that returns dummy data for any asset key.
class _FakeAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async => ByteData(100);
}

/// Wraps MaterialApp with LocaleCubit + a mock asset bundle for tests.
class _TestApp extends StatelessWidget {
  const _TestApp();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleCubit>(
      create: (_) => sl<LocaleCubit>(),
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return DefaultAssetBundle(
            bundle: _FakeAssetBundle(),
            child: MaterialApp(
              theme: AppTheme.light,
              locale: state.locale,
              supportedLocales: const [
                Locale('ar'),
                Locale('en'),
              ],
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              onGenerateRoute: AppRouter.generateRoute,
              initialRoute: AppRouter.splash,
            ),
          );
        },
      ),
    );
  }
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({'locale': 'ar'});
    await initDependencies();
  });

  tearDown(() {
    sl.reset();
  });

  testWidgets('Splash screen shows logo and loading indicator',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const _TestApp());
    await tester.pump();

    expect(find.byType(Image), findsOneWidget);
    expect(find.text('SHINUP'), findsOneWidget);
    expect(find.text('CLEAN . SHINE . PROTECT'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Splash navigates to login when no token',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const _TestApp());
    await tester.pump();

    // Advance fake clock past the 2-second timer
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Should now be on login page with Arabic welcome text
    expect(find.text('مرحباً بعودتك'), findsOneWidget);
  });

  testWidgets('Login page shows form fields and sign-up link',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const _TestApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Check for login page elements in Arabic
    expect(find.text('مرحباً بعودتك'), findsOneWidget);
    expect(find.text('تسجيل الدخول'), findsOneWidget);

    // Tap sign-up link to navigate to register
    await tester.tap(find.text('اشتراك'));
    await tester.pumpAndSettle();

    // Should now be on register page
    expect(find.text('إنشاء حساب'), findsOneWidget);
  });

  testWidgets('Register page shows all form fields',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const _TestApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Navigate to register
    await tester.tap(find.text('اشتراك'));
    await tester.pumpAndSettle();

    // Check register page elements in Arabic
    expect(find.text('إنشاء حساب'), findsOneWidget);
    expect(find.text('اشتراك'), findsOneWidget);
    expect(find.text('تسجيل الدخول'), findsOneWidget);
  });

  testWidgets('Can switch between login and register pages',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const _TestApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Start on login page
    expect(find.text('مرحباً بعودتك'), findsOneWidget);

    // Navigate to register
    await tester.tap(find.text('اشتراك'));
    await tester.pumpAndSettle();
    expect(find.text('إنشاء حساب'), findsOneWidget);

    // Scroll down so the login link is visible
    await tester.dragUntilVisible(
      find.text('تسجيل الدخول'),
      find.byType(SingleChildScrollView),
      const Offset(0, -300),
    );

    // Navigate back to login
    await tester.tap(find.text('تسجيل الدخول'));
    await tester.pumpAndSettle();
    expect(find.text('مرحباً بعودتك'), findsOneWidget);
  });
}
