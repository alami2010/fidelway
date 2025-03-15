import 'package:fidelway/contact.dart';
import 'package:fidelway/login/profile_screen.dart';
import 'package:fidelway/shared/local_storage_helper.dart';
import 'package:fidelway/subscribtion/fidelity_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';

import '../home.dart';
import '../login/sign_in.dart';
import '../subscribtion/pricing_screen.dart';
import '../subscribtion/terms_of_service.dart';
import '../tabs.dart';
import 'constant.dart';

class Utils {
  /// Checks if a string is null or empty
  static bool isNullOrEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  static void showErreur(titre) {
    Fluttertoast.showToast(
        msg: titre,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showSucces(title) {
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  /// Generates a random string of a given length
  static String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(length, (index) => chars[(DateTime.now().millisecondsSinceEpoch + index) % chars.length]).join();
  }

  /// Formats a number with commas
  static String formatNumber(int number) {
    return number.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
  }

  /// Returns the current timestamp in milliseconds
  static int getCurrentTimestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// Capitalizes the first letter of a string
  static String capitalize(String value) {
    if (isNullOrEmpty(value)) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  static AssetImage getLogo() => AssetImage('assets/logo.png');

  static AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const FildelityBar(),
    );
  }

  static Drawer buildDrawer(BuildContext context) {
    var account = LocalStorageHelper.getAccount();

    return Drawer(
      child: ListView(
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
                        getLogoWidget(),
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
              const HomeScreen().launch(context);
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
              String text = "Check out this amazing website: https://example.com";
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
            onTap: () {
              const PrivacyPolicyPage().launch(context);
            },
            leading: const Icon(
              FontAwesomeIcons.infoCircle,
              color: kGreyTextColor,
            ),
            title: Text(
              'Conditions d\'utilisation',
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
    );
  }

  static Container getLogoWidget() {
    return Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(20), // Border radius
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          // Apply border radius to image
          child: Image(image: AssetImage("assets/logo.png"))),
    );
  }

  static Center getLoading() {
    return Center(child: SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? kMainColor : kGreyTextColor,
          ),
        );
      },
    ));
  }

  static Future<bool?> showYesNoDialog(BuildContext context, String title) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Confirmation"), // Use the provided title
              content: Text(title),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false), // Return false
                  child: const Text("Non"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true), // Return true
                  child: const Text("Oui"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
