// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pricing_cards/pricing_cards.dart';
import 'package:url_launcher/url_launcher.dart';

import '../shared/constant.dart';
import '../shared/local_storage_helper.dart';
import '../shared/menu.dart';
import '../tabs.dart';

// ignore_for_file: library_private_types_in_public_api
class PricingScreen extends StatefulWidget {
  const PricingScreen({Key? key}) : super(key: key);

  @override
  _PricingScreenState createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  var account = LocalStorageHelper.getAccount();

  @override
  Widget build(BuildContext context) {
    var subscribed = (account?.subscribed ?? false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const FildelityBar(),
      ),
      drawer: MyDrawer(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    width: context.width(),
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                      color: kBgColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),

                        Container(
                          width: context.width() * 0.95,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: subscribed ? kGreenColor : kRedColor,
                                width: 10.0,
                              ),
                            ),
                            color: const Color(0xFFDAF3FF),
                          ),
                          child: ListTile(
                            onTap: () {
                              print("go to payment screen");

                              // PaymentScreen().launch(context);
                            },
                            leading: Icon(
                              subscribed ? CupertinoIcons.timer_fill : CupertinoIcons.time,
                              color: subscribed ? kGreenColor : kRedColor,
                            ),
                            title: Text(
                              subscribed ? "Votre abonnement est Actif" : "Votre abonnement est Expiré",
                              maxLines: 2,
                              style: kTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              subscribed
                                  ? "Votre abonnement expire le ${DateFormat('dd/MM/yyyy').format(account?.subscriptionExpiryDate ?? DateTime.now())}"
                                  : "Votre abonnement est expiré la date ${DateFormat('yyyy-MM-dd').format(account?.subscriptionExpiryDate ?? DateTime.now())}",
                              maxLines: 2,
                              style: kTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: context.width() * 0.95,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: kAlertColor,
                                      width: 10.0,
                                    ),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  subscribed ? 'Choisissez et prolongez votre abonnement' : 'Choisissez et activez votre abonnement',
                                  style: kTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: kAlertColor),
                                ),
                              ),
                              SizedBox(height: 30),
                              PricingCards(
                                pricingCards: [
                                  PricingCard(
                                    title: 'Mensuel',
                                    price: '9,99 €',
                                    subPriceText: '/mois',
                                    billedText: 'Facturé mensuellement',
                                    onPress: () {
                                      _launchURLPayment(PaymentType.monthly);
                                    },
                                    cardColor: Colors.green,
                                    priceStyle: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    titleStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    billedTextStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                    subPriceStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                    cardBorder: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.red, width: 4.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  PricingCard(
                                    title: 'Annuel',
                                    price: '59,99 €',
                                    subPriceText: '/an',
                                    billedText: 'Facturé annuellement',
                                    mainPricing: true,
                                    mainPricingHighlightText: 'Économisez de l\'argent',
                                    onPress: () {
                                      _launchURLPayment(PaymentType.annually);
                                    },
                                    cardColor: Colors.blue,
                                    priceStyle: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    titleStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    billedTextStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                    subPriceStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                    cardBorder: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.red, width: 4.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: kMainColor,
                                width: 5.0,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Text(
                            'Économies significatives : Passez d’un coût annuel de 520 € à 300 €, soit 42% d’économies !',
                            style: kTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: kMainColor,
                                width: 5.0,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Text(
                            'Fiabilité accrue : Les QR codes uniques suppriment tout risque de perte, d’usure ou de fraude.',
                            style: kTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10.0),

                        Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: kMainColor,
                                width: 5.0,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Text(
                            'Flexibilité et modernité : Configurez vos offres en temps réel pour mieux répondre aux attentes de vos clients.',
                            style: kTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10.0),

                        Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: kMainColor,
                                width: 5.0,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Text(
                            'Solution écologique et durable : Dites adieu aux cartes papier jetables et réduisez votre empreinte écologique.',
                            style: kTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Option',
                                      style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Coût annuel (€)',
                                      style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Points clés',
                                      style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1.0,
                                color: kGreyTextColor.withOpacity(0.2),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Cartes papier classiques',
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '520 €',
                                      textAlign: TextAlign.center,
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Coût élevé, peu pratique et rigide',
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Fidelway (papier + appli)',
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '460 €',
                                      textAlign: TextAlign.center,
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Économique et hybride',
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Fidelway 100% numérique',
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '300 €',
                                      textAlign: TextAlign.center,
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'La solution la plus économique',
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Avec Fidelway, non seulement vous réalisez des économies substantielles, mais vous offrez également une expérience client moderne et écologique.',
                          style: kTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Passez dès aujourd’hui à Fidelway et profitez d’une fidélisation simple, fiable et durable !',
                          style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ), // Espace supplémentaire pour le défilement
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset("assets/images/premium.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final String baseUrl = "https://fidelway.enovway.com/payment";

  Future<void> _launchURLPayment(PaymentType type) async {
    // Construire l'URL avec les paramètres
    var idMarchand = LocalStorageHelper.getAccount()?.id?.toString() ?? "";
    final Uri uri = Uri.parse("$baseUrl?type=${type.value}&client=$idMarchand");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Impossible d'ouvrir l'URL : $uri";
    }
  }
}

// Définition de l'enum pour les types
enum PaymentType { monthly, annually }

// Extension pour convertir l'enum en String
extension PaymentTypeExtension on PaymentType {
  String get value {
    switch (this) {
      case PaymentType.monthly:
        return "monthly";
      case PaymentType.annually:
        return "annually";
    }
  }
}
