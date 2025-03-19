import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nb_utils/nb_utils.dart';

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
