import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../shared/constant.dart';
import '../shared/language_service.dart';
import '../shared/language_provider.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({Key? key}) : super(key: key);

  @override
  _LanguageSettingsScreenState createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  Locale _selectedLocale = LanguageService.french;

  @override
  void initState() {
    super.initState();
    _loadCurrentLanguage();
  }

  Future<void> _loadCurrentLanguage() async {
    final currentLocale = await LanguageService.getSavedLanguage();
    setState(() {
      _selectedLocale = currentLocale;
    });
  }

  Future<void> _changeLanguage(Locale locale) async {
    setState(() {
      _selectedLocale = locale;
    });

    // Use the provider to change language
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    await languageProvider.changeLanguage(locale);

    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(AppLocalizations.of(context)!.languageChangedSuccessfully),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: kTextStyle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.languageSettings,
                style: kTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kMainColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.chooseLanguage,
                style: kTextStyle.copyWith(
                  fontSize: 16,
                  color: kGreyTextColor,
                ),
              ),
              const SizedBox(height: 32),
              _buildLanguageOption(
                LanguageService.english,
                AppLocalizations.of(context)!.english,
                '🇺🇸',
                AppLocalizations.of(context)!.english,
              ),
              const SizedBox(height: 16),
              _buildLanguageOption(
                LanguageService.french,
                AppLocalizations.of(context)!.french,
                '🇫🇷',
                AppLocalizations.of(context)!.french,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    Locale locale,
    String languageName,
    String flag,
    String englishName,
  ) {
    final isSelected = _selectedLocale.languageCode == locale.languageCode;

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? kMainColor.withOpacity(0.1) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? kMainColor : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        leading: Text(
          flag,
          style: const TextStyle(fontSize: 24),
        ),
        title: Text(
          languageName,
          style: kTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            color: isSelected ? kMainColor : Colors.black87,
          ),
        ),
        subtitle: Text(
          englishName,
          style: kTextStyle.copyWith(
            color: kGreyTextColor,
            fontSize: 14,
          ),
        ),
        trailing: isSelected
            ? Icon(
                Icons.check_circle,
                color: kMainColor,
                size: 24,
              )
            : Icon(
                Icons.radio_button_unchecked,
                color: Colors.grey.shade400,
                size: 24,
              ),
        onTap: () => _changeLanguage(locale),
      ),
    );
  }
}
