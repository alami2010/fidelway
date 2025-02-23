import 'dart:convert';

import 'package:FidelWay/model/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/account.dart';

class LocalStorageHelper {
  static late SharedPreferences prefs;
  static String LOGIN_INFO = "login_info";
  static String ACCOUNT_KEY = "ACCOUNT_KEY";
  static String CATEGORY_KEY = "CATEGORY_KEY";

  static String USER_TOKEN_KEY = "USER_TOKEN_KEY";
  static String LATITUDE_KEY = "LATITUDE_KEY";
  static String SHOP_NAME = "SHOP_NAME";
  static String VISIT_COUNT = "VISIT_COUNT";
  static String OFFERT = "OFFERT";

  static String MODE_KEY = "LONGITUDE_KEY";
  static String ONBOARD_SHOWN = "ONBOARD_SHOWN";

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void writeShopName(String name) {
    prefs.setString(SHOP_NAME, name);
  }

  static String? readShopName() {
    return prefs.getString(SHOP_NAME);
  }

  static void writeMode(int name) {
    prefs.setString(MODE_KEY, name.toString());
  }

  static String? readMode() {
    return prefs.getString(MODE_KEY) ?? '';
  }

  static void writeCountVisit(String name) {
    prefs.setString(VISIT_COUNT, name);
  }

  static String? readCountVisit() {
    return prefs.getString(VISIT_COUNT);
  }

  static void writeOffert(String name) {
    prefs.setString(OFFERT, name);
  }

  static String? readOffert() {
    return prefs.getString(OFFERT);
  }

  static void writeUserToken(String token) {
    prefs.setString(USER_TOKEN_KEY, token);
  }

  static String? readUserToken() {
    return prefs.getString(USER_TOKEN_KEY);
  }

  static Category? getCategory() {
    String? accountMapPref = prefs.getString(CATEGORY_KEY);
    if (accountMapPref == null) return null;
    Map<String, dynamic> accountMap =
        jsonDecode(accountMapPref) as Map<String, dynamic>;

    return Category.fromJson(accountMap);
  }

  static saveCategory(Category? category) {
    prefs.setString(CATEGORY_KEY, jsonEncode(category));
  }

  static Account? getAccount() {
    String? accountMapPref = prefs.getString(ACCOUNT_KEY);
    if (accountMapPref == null) return null;
    Map<String, dynamic> accountMap =
        jsonDecode(accountMapPref) as Map<String, dynamic>;

    return Account.fromJson(accountMap);
  }

  static saveAccount(Account account) {
    prefs.setString(ACCOUNT_KEY, jsonEncode(account));
  }

  static bool getOboarding() {
    return prefs.getBool(ONBOARD_SHOWN) ?? false;
  }

  static void setOboarding() {
    prefs.setBool(ONBOARD_SHOWN, true);
  }

  static void logOut() {
    prefs.remove(LOGIN_INFO);
    prefs.remove(ACCOUNT_KEY);
    prefs.remove(CATEGORY_KEY);
    prefs.remove(USER_TOKEN_KEY);
  }
}
