import 'package:flutter/material.dart';
import 'language_service.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = LanguageService.french;

  Locale get currentLocale => _currentLocale;

  Future<void> loadSavedLanguage() async {
    final savedLocale = await LanguageService.getSavedLanguage();
    _currentLocale = savedLocale;
    notifyListeners();
  }

  Future<void> changeLanguage(Locale locale) async {
    _currentLocale = locale;
    await LanguageService.saveLanguage(locale);
    notifyListeners();
  }
}
