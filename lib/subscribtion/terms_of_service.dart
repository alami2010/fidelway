import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../shared/constant.dart';
import '../shared/utils.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String policy = """
    Bienvenue sur Fildelway ! Votre confidentialité est importante pour nous. Cette politique de confidentialité explique comment nous collectons, utilisons, divulguons et protégeons vos informations personnelles lorsque vous utilisez notre application et nos services.
    
    1. Informations que nous collectons
    - Informations personnelles : Nom, adresse e-mail, numéro de téléphone et autres détails fournis lors de l'inscription.
    - Données d'utilisation : Informations sur votre interaction avec l'application, y compris les journaux, l'adresse IP, les informations sur l'appareil et les cookies.
    - Fichiers et contenu : Si l'application implique le partage ou le stockage de fichiers, nous pouvons collecter et traiter les fichiers que vous téléchargez ou partagez.
    
    2. Comment nous utilisons vos informations
    - Fournir et améliorer nos services.
    - Personnaliser l'expérience utilisateur.
    - Assurer la sécurité et prévenir la fraude.
    - Respecter les exigences légales.
    - Communiquer avec les utilisateurs à propos des mises à jour et du support.
    
    [Autres sections de la politique...]
    """;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      drawer: Utils.buildDrawer(context),
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Politique de Confidentialité',
          style: kTextStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          Expanded(
            child: Container(
              width: context.width(),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: kBgColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    Container(
                      width: context.width(),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Politique de Confidentialité',
                            style: kTextStyle.copyWith(fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Date d\'entrée en vigueur : [Insérer la date]',
                            style: kTextStyle.copyWith(color: kGreyTextColor),
                          ),
                          Text(
                            policy,
                            style: kTextStyle.copyWith(color: kGreyTextColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}