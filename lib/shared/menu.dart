import 'package:fidelway/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'local_storage_helper.dart'; // For SpinKitFadingCircle

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var account = LocalStorageHelper.getAccount();


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: context.height() / 3,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
                  color: kMainColor,
                ),
                child: Column(
                  children: [
                    Container(
                      height: context.height() / 4,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Utils.getLogoWidget(),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              '${account?.firstName ?? ''}  ',
                              style: kTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: kMainColor,
                              ),
                            ),
                          ],
                        ).onTap(() {
                          const ProfileScreen().launch(context);
                        }),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              '12',
                              style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Ajd',
                              style: kTextStyle.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Total',
                              style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '50',
                              style: kTextStyle.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ListTile(
                onTap: () {
                  const HomeScreen().launch(context);
                },
                leading: const Icon(
                  Icons.home,
                  color: kGreyTextColor,
                ),
                title: Text(
                  'Accueil',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: kGreyTextColor,
                ),
              ),
              ListTile(
                onTap: () {
                  const ProfileScreen().launch(context);
                },
                leading: const Icon(
                  Icons.person,
                  color: kGreyTextColor,
                ),
                title: Text(
                  'Porfile',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: kGreyTextColor,
                ),
              ),
              ListTile(
                onTap: () {
                  const HomeScreen().launch(context);
                },
                leading: const Icon(
                  Icons.camera_alt_rounded,
                  color: kGreyTextColor,
                ),
                title: Text(
                  'Scanner une carte',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: kGreyTextColor,
                ),
              ),
              ListTile(
                onTap: () {
                  ImprovedLoyaltyScreen().launch(context);
                },
                leading: const Icon(
                  Icons.camera_alt_rounded,
                  color: kGreyTextColor,
                ),
                title: Text(
                  'Guide d\'utilisation',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: kGreyTextColor,
                ),
              ),
              ListTile(
                onTap: () {
                  FidelityScreen().launch(context);
                },
                leading: const Icon(
                  Icons.settings,
                  color: kGreyTextColor,
                ),
                title: Text(
                  'Paramètres',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: kGreyTextColor,
                ),
              ),
              ListTile(
                onTap: () {
                  const PricingScreen().launch(context);
                },
                leading: const Icon(
                  FontAwesomeIcons.medal,
                  color: kGreyTextColor,
                ),
                title: Text(
                  'Souscription',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: kGreyTextColor,
                ),
              ),
              ListTile(
                onTap: () {
                  const PrivacyPolicyPage().launch(context);
                },
                leading: const Icon(
                  FontAwesomeIcons.coffee,
                  color: kGreyTextColor,
                ),
                title: Text(
                  'Politique de confidentialité',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: kGreyTextColor,
                ),
              ),
              ListTile(
                onTap: () {
                  String text = '''Bonjour !
              Je t'invite à rejoindre Fildeyway, une application géniale qui te permet de [mentionner les fonctionnalités de l'application]. C’est simple, rapide et parfait pour [bénéfices de l'application].
              Clique sur ce lien pour t’inscrire et commencer à profiter de tous ses avantages : https://fidelway.enovway.com/.

              À bientôt sur l’app ! 😊''';
                  Share.share(text);
                },
                leading: const Icon(
                  FontAwesomeIcons.peopleGroup,
                  color: kGreyTextColor,
                ),
                title: Text(
                  'Partager avec des amis',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: kGreyTextColor,
                ),
              ),
              ListTile(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DownloadImageModal(
                        closeModal: () => Navigator.of(context).pop(),
                      );
                    },
                  );
                },
                leading: const Icon(
                  FontAwesomeIcons.caretDown,
                  color: kGreyTextColor,
                ),
                title: Text(
                  'Création carte client',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: kGreyTextColor,
                ),
              ),
              ListTile(
                onTap: () {
                  const ContactUs().launch(context);
                },
                leading: const Icon(
                  Icons.info_outline,
                  color: kGreyTextColor,
                ),
                title: Text(
                  'Nous conatcter',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: kGreyTextColor,
                ),
              ),
              ListTile(
                onTap: () {
                  LocalStorageHelper.logOut();
                  const SignIn().launch(context);
                },
                leading: const Icon(
                  FontAwesomeIcons.signOutAlt,
                  color: kGreyTextColor,
                ),
                title: Text(
                  'Déconnexion',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: kGreyTextColor,
                ),
              ),
            ],
          ),
          // Loading overlay
        ],
      ),
    );
  }
}
