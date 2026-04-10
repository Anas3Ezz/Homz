import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/locale_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('app_name'.tr()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'app_name'.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () =>
                  LocaleUtils.switchLanguage(context, LocaleUtils.english),
              child: const Text('Switch to English'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () =>
                  LocaleUtils.switchLanguage(context, LocaleUtils.arabic),
              child: const Text('Switch to Arabic'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  //TODO, the theme of the app, the responsive Ui from the start,
  // using gap package, and class AppColor for the app,
  // the splash screen & the app icon
}
