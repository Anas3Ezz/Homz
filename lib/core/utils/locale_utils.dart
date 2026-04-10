import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocaleUtils {
  static const Locale english = Locale('en');
  static const Locale arabic = Locale('ar');

  static Future<void> switchLanguage(
    BuildContext context,
    Locale locale,
  ) async {
    await context.setLocale(locale);
  }
}
