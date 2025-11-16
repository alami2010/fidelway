import 'package:fidelway/login/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

import '../home.dart';
import '../model/APIRest.dart';
import '../model/jwt_response.dart';
import '../shared/constant.dart';
import '../shared/local_storage_helper.dart';
import '../subscribtion/fidelity_screen.dart';

class LoginService {
  Future<void> afterLogin(JwtResponse value, BuildContext context) async {
    LocalStorageHelper.writeUserToken(value.token ?? '');

    await afterLoginAccount(context);
  }

  Future<void> afterLoginAccount(BuildContext context) async {
    var account = await APIRest.getAcount();

    if (account != null) {
      LocalStorageHelper.saveAccount(account);
    } else {
      const SignIn().launch(context, isNewTask: true);
      return;
    }

    var category =
        await APIRest.getCategory() ?? await LocalStorageHelper.getCategory();

    final bool hasValidCategory =
        category != null && (category.choices.isNotEmpty);

    if (!hasValidCategory) {
      // Ensure we route user to configure category before using the app
      FidelityScreen().launch(context, isNewTask: true);
      return;
    }

    // Convert choice names to localization keys for proper i18n
    category = convertCategoryChoicesToKeys(context, category);
    LocalStorageHelper.saveCategory(category);
    const HomeScreen().launch(context, isNewTask: true);
  }
}
