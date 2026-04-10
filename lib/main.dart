import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homz/core/routs/app_routers.dart';
import 'package:homz/core/routs/app_routs.dart';

import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // ✅ Must be called after ensureInitialized
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // white icons (Android)
      statusBarBrightness: Brightness.dark, // white icons (iOS)
    ),
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app_name'.tr(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: EasyLocalization.of(context)!.delegates,
      supportedLocales: EasyLocalization.of(context)!.supportedLocales,
      locale: EasyLocalization.of(context)!.locale,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.onboarding,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
