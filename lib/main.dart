import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shineup/core/di/service_locator.dart';
import 'package:shineup/core/localization/locale_cubit.dart';
import 'package:shineup/core/routes/app_pages.dart';
import 'package:shineup/core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shineup/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  await initDependencies();
  runApp(const ShineupApp());
}

class ShineupApp extends StatelessWidget {
  const ShineupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleCubit>(
      create: (_) => sl<LocaleCubit>(),
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Shineup',
            debugShowCheckedModeBanner: false,
            locale: state.locale,
            supportedLocales: const [
              Locale('ar'),
              Locale('en'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeMode.system,
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: AppRouter.splash,
          );
        },
      ),
    );
  }
}
