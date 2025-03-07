import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

import '../home.dart';
import '../model/APIRest.dart';
import '../model/jwt_response.dart';
import '../shared/local_storage_helper.dart';
import '../subscribtion/fidelity_screen.dart';

class LoginService {
  Future<void> afterLogin(JwtResponse value, BuildContext context) async {
    LocalStorageHelper.writeUserToken(value.token ?? '');

    var account = await APIRest.getAcount();

    if (account != null) {
      LocalStorageHelper.saveAccount(account);
    }

    var category = await APIRest.getCategory() ?? await LocalStorageHelper.getCategory();
    if (category == null) {
      FidelityScreen().launch(context);
    } else {
      LocalStorageHelper.saveCategory(category);
      const HomeScreen().launch(context);
    }
  }
}
