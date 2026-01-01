import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:sama_taxi/core/navigation/app_router.dart';
import 'package:sama_taxi/core/providers/theme_provider.dart';
import 'package:sama_taxi/core/services/logging_service.dart';
import 'package:sama_taxi/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logging
  logger.initialize(level: Level.ALL);

  await EasyLocalization.ensureInitialized();
  logger.info('Localization initialized');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
   final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'sama_taxi',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.lightTheme,
     // darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
    //   home: const OnboardingScreen(),
    //   //HomeScreen(),
      
     // initialRoute: '/home',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
