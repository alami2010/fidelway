import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = 'selected_language';

  static const Locale english = Locale('en', '');
  static const Locale french = Locale('fr', '');

  static const List<Locale> supportedLocales = [english, french];

  static Future<Locale> getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode =
        prefs.getString(_languageKey) ?? 'fr'; // Default to French
    return Locale(languageCode, '');
  }

  static Future<void> saveLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, locale.languageCode);
  }

  static String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      default:
        return 'Français';
    }
  }
}
