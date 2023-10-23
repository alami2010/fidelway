import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {
  static late SharedPreferences prefs;
  static String LOGIN_INFO = "login_info";
  static String ACCOUNT_KEY = "ACCOUNT_KEY";
  static String USER_TOKEN_KEY = "USER_TOKEN_KEY";
  static String LATITUDE_KEY = "LATITUDE_KEY";
  static String SHOP_NAME = "SHOP_NAME";
  static String VISIT_COUNT = "VISIT_COUNT";
  static String OFFERT = "OFFERT";

  static String MODE_KEY = "LONGITUDE_KEY";

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
}
