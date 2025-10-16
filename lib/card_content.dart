import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'shared/language_provider.dart';

class CardContent extends StatelessWidget {
  final String name;
  final String date;

  const CardContent({super.key, 
    required this.name,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text(
            date,
            style: const TextStyle(color: Colors.grey),
          ),

          Row(
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF162A49),
                  textStyle: const TextStyle(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: () {},
                    child: Text(AppLocalizations.of(context)!.reserve),
                  ),
              const Spacer(),
              const Text(
                '0.00 \$',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

            ],
          )
        ],
      ),
    );
      },
    );
  }
}
