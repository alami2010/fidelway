import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../shared/constant.dart';
import '../shared/menu.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Politique de Confidentialité',
          style: kTextStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Container(
        width: context.width(),
        decoration: const BoxDecoration(
          color: kBgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 60,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Politique de Confidentialité de Fidelway',
                        style: kTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Date d\'entrée en vigueur : 01 Janvier 2025',
                        style: kTextStyle.copyWith(
                          fontSize: 14,
                          color: kGreyTextColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _sectionTitle('1. Introduction'),
                      _sectionText(
                          'Bienvenue sur Fidelway ! Votre vie privée est importante pour nous. Cette politique décrit comment nous collectons, utilisons et protégeons vos données personnelles.'),
                      const SizedBox(height: 12),
                      _sectionTitle('2. Données que nous collectons'),
                      _sectionText('• Données personnelles : nom, email, téléphone...\n'
                          '• Données d’utilisation : journal d’activité, appareil utilisé, cookies...\n'
                          '• Contenus partagés : fichiers ou médias uploadés dans l’app.'),
                      const SizedBox(height: 12),
                      _sectionTitle('3. Utilisation des données'),
                      _sectionText(
                          'Nous utilisons vos données pour améliorer nos services, assurer la sécurité, personnaliser l’expérience et répondre à nos obligations légales.'),
                      const SizedBox(height: 12),
                      _sectionTitle('4. Partage et sécurité'),
                      _sectionText(
                          'Vos informations ne sont jamais vendues. Nous appliquons des mesures de sécurité strictes pour protéger vos données.'),
                      const SizedBox(height: 12),
                      _sectionTitle('5. Vos droits'),
                      _sectionText('Vous pouvez accéder, corriger ou supprimer vos données à tout moment en nous contactant.'),
                      const SizedBox(height: 12),
                      _sectionTitle('6. Contact'),
                      _sectionText('Pour toute question concernant cette politique, veuillez nous contacter à support@fidelway.com.'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: kTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _sectionText(String content) {
    return Text(
      content,
      style: kTextStyle.copyWith(
        fontSize: 14,
        height: 1.5,
        color: kGreyTextColor,
      ),
    );
  }
}
