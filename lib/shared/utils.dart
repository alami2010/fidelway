import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../tabs.dart';
import 'constant.dart';

class Utils {
  /// Checks if a string is null or empty
  static bool isNullOrEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  static void showErreur(String message, {String value = '', required BuildContext context}) {
    showTopSnackBar(context, message, Colors.red);
  }

  static void showSucces(String message, {String value = '', required BuildContext context}) {
    showTopSnackBar(context, message, Colors.green);
  }

  static void showTopSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).clearSnackBars(); // Clear existing SnackBars

    // Manually position SnackBar at the top
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 50, left: 20, right: 20), // Adjust top margin
      ),
    );
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
      backgroundColor: kMainColor,
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
