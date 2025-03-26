import 'package:fidelway/shared/constant.dart';
import 'package:fidelway/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../shared/menu.dart';

class ImprovedLoyaltyScreen extends StatelessWidget {
  const ImprovedLoyaltyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: Utils.buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Card(
              color: kMainColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Découvrez Fidelway',
                      style: kTextStyle.copyWith(color: Colors.white),
                    ),
                    8.height,
                    Text('La Solution Moderne de Fidélisation Client',
                        style: kTextStyle.copyWith(fontSize: 16, color: Colors.white), textAlign: TextAlign.center),
                    16.height,
                    Text('Simplifiez la fidélisation, boostez votre chiffre d\'affaires et réduisez vos coûts avec Fidelway !',
                        style: kTextStyle.copyWith(color: Colors.white), textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            16.height,

            // Why Choose Section
            SectionTitle(title: '✔ Pourquoi choisir Fidelway ?'),
            8.height,
            BenefitItem(icon: Icons.eco, text: 'Écologique : Plus de gaspillage de papier'),
            BenefitItem(icon: Icons.attach_money, text: 'Économique : Jusqu\'à 42% d\'économies'),
            BenefitItem(icon: Icons.settings, text: 'Flexible : Programmes personnalisables'),
            BenefitItem(icon: Icons.security, text: 'Fiable : QR codes uniques et sécurisés'),
            BenefitItem(icon: Icons.phone_iphone, text: 'Moderne : Expérience client digitale'),
            16.height,

            // Features Section
            SectionTitle(title: '📱 Fonctionnalités clés'),
            8.height,
            SubSectionTitle(title: 'Pour les commerçants :'),
            FeatureItem(text: '📊 Tableau de bord intuitif'),
            FeatureItem(text: '🎨 Personnalisation totale'),
            FeatureItem(text: '📲 Gestion simplifiée'),
            8.height,
            SubSectionTitle(title: 'Pour les clients :'),
            FeatureItem(text: '📱 Carte numérique ou QR code papier'),
            FeatureItem(text: '🔔 Notifications de progression'),
            FeatureItem(text: '🔄 Réutilisable à vie'),
            16.height,

            // Examples Section
            SectionTitle(title: '💡 Exemples concrets'),
            8.height,
            ExampleCard(
              icon: Icons.local_pizza,
              title: 'Pizzeria',
              items: [
                '10 commandes → 1 boisson offerte',
                '15 commandes → 1 pizza junior',
                '20 commandes → 1 pizza senior',
              ],
            ),
            8.height,
            ExampleCard(
              icon: Icons.cut,
              title: 'Salon de coiffure',
              items: [
                '5 visites → 1 soin gratuit',
              ],
            ),
            16.height,

            // Pricing Comparison
            SectionTitle(title: '💶 Combien ça coûte ?'),
            8.height,
            Text('Avec Fidelway, économisez des centaines d\'euros par an :', style: TextStyle(fontSize: 16)),
            16.height,
            PricingComparisonTable(),
            16.height,
            Text('➡ En choisissant l\'option numérique, vous économisez 220 €/an !', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            24.height,

            // CTA Section
            SectionTitle(title: '🎯 Comment commencer ?'),
            8.height,
            StepItem(number: '1️⃣', text: 'Téléchargez l\'appli (iOS/Android)'),
            StepItem(number: '2️⃣', text: 'Créez votre compte commerçant'),
            StepItem(number: '3️⃣', text: 'Paramétrez votre programme'),
            StepItem(number: '4️⃣', text: 'Communiquez auprès de vos clients'),
            24.height,
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text('ABONNEZ-VOUS MAINTENANT', style: TextStyle(fontSize: 16)),
              ),
            ),
            24.height,

            // FAQ Section
            SectionTitle(title: '❓ Questions fréquentes'),
            8.height,
            FaqItem(
              question: 'Un client perd sa carte papier ?',
              answer: 'Il peut la récupérer via l\'appli.',
            ),
            FaqItem(
              question: 'Modifiable à tout moment ?',
              answer: 'Oui, ajustez vos règles depuis le tableau de bord.',
            ),
            FaqItem(
              question: 'Sécurisé ?',
              answer: 'Absolument, chaque QR code est unique et infalsifiable.',
            ),
            16.height,
            Center(
              child: Text('Fidelway, la fidélisation intelligente et durable. Essayez-la dès aujourd\'hui ! 😊',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
            ),
            32.height,
          ],
        ),
      ),
    );
  }
}

// Reusable Widget Components
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }
}

class SubSectionTitle extends StatelessWidget {
  final String title;

  const SubSectionTitle({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 4),
      child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}

class BenefitItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const BenefitItem({required this.icon, required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.green),
          8.width,
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String text;

  const FeatureItem({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 28), // For alignment with BenefitItem
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

class ExampleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> items;

  const ExampleCard({
    required this.icon,
    required this.title,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                8.width,
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            8.height,
            ...items
                .map(
                  (item) => Padding(padding: EdgeInsets.only(left: 32, bottom: 4), child: Text('• $item', style: TextStyle(fontSize: 14))),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

class PricingComparisonTable extends StatelessWidget {
  const PricingComparisonTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text('Option', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Coût annuel', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                Expanded(flex: 2, child: Text('Avantages', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          // Table Rows
          TableRowItem(
            option: 'Cartes papier classiques',
            cost: '520 €',
            benefits: 'Coûteux, peu pratique',
            isHighlighted: false,
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          TableRowItem(
            option: 'Fidelway (hybride)',
            cost: '460 €',
            benefits: 'Économique + QR code physique',
            isHighlighted: false,
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          TableRowItem(
            option: 'Fidelway 100% numérique',
            cost: '300 €',
            benefits: 'Solution la plus avantageuse !',
            isHighlighted: true,
          ),
        ],
      ),
    );
  }
}

class TableRowItem extends StatelessWidget {
  final String option;
  final String cost;
  final String benefits;
  final bool isHighlighted;

  const TableRowItem({
    required this.option,
    required this.cost,
    required this.benefits,
    this.isHighlighted = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: isHighlighted ? Colors.green[50] : Colors.white,
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(option)),
          Expanded(child: Text(cost, textAlign: TextAlign.center, style: isHighlighted ? TextStyle(fontWeight: FontWeight.bold) : null)),
          Expanded(flex: 2, child: Text(benefits)),
        ],
      ),
    );
  }
}

class StepItem extends StatelessWidget {
  final String number;
  final String text;

  const StepItem({required this.number, required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(number, style: TextStyle(fontSize: 16)),
          8.width,
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const FaqItem({required this.question, required this.answer, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: TextStyle(fontWeight: FontWeight.bold)),
          4.height,
          Text(answer),
          8.height,
        ],
      ),
    );
  }
}
