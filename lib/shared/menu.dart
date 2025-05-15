import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';

import '../contact.dart';
import '../home.dart';
import '../login/profile_screen.dart';
import '../login/sign_in.dart';
import '../subscribtion/fidelity_screen.dart';
import '../subscribtion/guide_user.dart';
import '../subscribtion/pricing_screen.dart';
import '../subscribtion/terms_of_service.dart';
import 'constant.dart';
import 'download_image.dart';
import 'local_storage_helper.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with SingleTickerProviderStateMixin {
  final account = LocalStorageHelper.getAccount();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      elevation: 0,
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      child: FadeTransition(
        opacity: _animation,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildHeader(context, isDark),
              //_buildUserStats(context, isDark),
              _buildDrawerItems(context, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 50, bottom: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark ? [Colors.grey[850]!, Colors.grey[900]!] : [kMainColor.withOpacity(0.95), kMainColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            '${account?.firstName ?? 'Invité'}',
            style: kTextStyle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => const ProfileScreen().launch(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Voir le profil',
                style: kTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserStats(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatCard("12", "Aujourd'hui", Icons.today, isDark),
          Container(
            height: 40,
            width: 1,
            color: isDark ? Colors.grey[700] : Colors.grey[300],
          ),
          _buildStatCard("50", "Total", Icons.insights, isDark),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, bool isDark) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: kTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: isDark ? Colors.white : kMainColor,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              icon,
              size: 16,
              color: isDark ? Colors.grey[400] : kMainColor.withOpacity(0.7),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: kTextStyle.copyWith(
            fontSize: 12,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDrawerItems(BuildContext context, bool isDark) {
    return Column(
      children: [
        _buildSection(
          context,
          "Navigation",
          [
            _buildMenuItem(
              context,
              Icons.qr_code_scanner,
              "Scanner une carte",
              () => const HomeScreen().launch(context),
              isDark,
            ),
            _buildMenuItem(
              context,
              Icons.person_outline,
              "Profil",
              () => const ProfileScreen().launch(context),
              isDark,
              isActive: true,
            ),
          ],
          isDark,
        ),
        _buildSection(
          context,
          "Fonctionnalités",
          [
            _buildMenuItem(
              context,
              Icons.menu_book_outlined,
              "Guide d'utilisation",
              () => ImprovedLoyaltyScreen().launch(context),
              isDark,
            ),
            _buildMenuItem(
              context,
              Icons.card_membership_outlined,
              "Souscription",
              () => const PricingScreen().launch(context),
              isDark,
            ),
            _buildMenuItem(
              context,
              Icons.credit_card_outlined,
              "Création carte client",
              () {
                showDialog(
                  context: context,
                  builder: (context) => DownloadImageModal(closeModal: () => Navigator.of(context).pop()),
                );
              },
              isDark,
            ),
          ],
          isDark,
        ),
        _buildSection(
          context,
          "Support & Légal",
          [
            _buildMenuItem(
              context,
              Icons.settings_outlined,
              "Paramètres",
              () => FidelityScreen().launch(context),
              isDark,
            ),
            _buildMenuItem(
              context,
              Icons.privacy_tip_outlined,
              "Politique de confidentialité",
              () => const PrivacyPolicyPage().launch(context),
              isDark,
            ),
            _buildMenuItem(
              context,
              Icons.support_agent_outlined,
              "Nous contacter",
              () => const ContactUs().launch(context),
              isDark,
            ),
          ],
          isDark,
        ),
        _buildSection(
          context,
          "Partage",
          [
            _buildMenuItem(
              context,
              Icons.share_outlined,
              "Partager avec des amis",
              () {
                Share.share(
                  '''Bonjour !
Je t'invite à rejoindre Fidelway, une application géniale qui te permet de gérer tes cartes de fidélité. C'est simple, rapide et parfait pour économiser du temps et de l'argent.
Clique ici : https://fidelway.enovway.com/

À bientôt ! 😊''',
                );
              },
              isDark,
            ),
          ],
          isDark,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Divider(
            color: isDark ? Colors.grey[800] : Colors.grey[300],
            thickness: 1,
          ),
        ),
        _buildLogoutButton(context, isDark),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> items, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
            child: Text(
              title.toUpperCase(),
              style: kTextStyle.copyWith(
                color: isDark ? Colors.grey[400] : kMainColor.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isDark
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Column(children: items),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
    bool isDark, {
    bool isActive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: isDark ? Colors.white10 : kMainColor.withOpacity(0.1),
        highlightColor: isDark ? Colors.white10 : kMainColor.withOpacity(0.05),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isActive
                ? isDark
                    ? kMainColor.withOpacity(0.2)
                    : kMainColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: isDark ? Colors.white70 : kMainColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: kTextStyle.copyWith(
                    color: isDark ? Colors.white : Colors.black87,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: isDark ? Colors.grey[600] : Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton.icon(
        onPressed: () {
          LocalStorageHelper.logOut();
          const SignIn().launch(context);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: isDark ? Colors.red[900] : Colors.red[50],
          foregroundColor: isDark ? Colors.white : Colors.red,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(
          Icons.logout,
          color: isDark ? Colors.white70 : Colors.red,
          size: 18,
        ),
        label: Text(
          'Déconnexion',
          style: kTextStyle.copyWith(
            color: isDark ? Colors.white : Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}