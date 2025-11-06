// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:fidelway/login/sign_in.dart';
import 'package:fidelway/model/APIRest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../shared/constant.dart';
import '../shared/language_provider.dart';
import '../shared/local_storage_helper.dart';
import '../shared/menu.dart';
import '../shared/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var account = LocalStorageHelper.getAccount();
  bool isLoading = false;

  void startLoading() => setState(() => isLoading = true);

  void stopLoading() => setState(() => isLoading = false);

  Future<void> _deleteAccount() async {
    startLoading();
    await APIRest.delete().then((value) {
      const SignIn().launch(context);
      Utils.showSucces(AppLocalizations.of(context)!.deleteMyAccount,
          context: context);
      stopLoading();
    }).catchError((error) {
      stopLoading();
      Utils.showErreur(AppLocalizations.of(context)!.errorChangingPassword,
          context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final subscribed = account?.subscribed ?? false;
        final subscriptionDate =
            account?.subscriptionExpiryDate ?? DateTime.now();
        final isSubscriptionExpired =
            !subscribed || DateTime.now().isAfter(subscriptionDate);
        // Check if app is in free mode
        final isFree = isAppFree;

        return Scaffold(
          drawer: MyDrawer(),
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
              AppLocalizations.of(context)!.myProfile,
              style: kTextStyle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {
              // Navigate to settings or show settings menu
                  toast(AppLocalizations.of(context)!.settings);
                },
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            width: context.width(),
            height: context.height(),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            margin: const EdgeInsets.only(top: 70),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                // Profile header with avatar
                Container(
                  width: context.width(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 4),
                              borderRadius: BorderRadius.circular(60),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: kMainColor,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: kMainColor,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                              onPressed: () {
                                    toast(AppLocalizations.of(context)!
                                        .changeProfilePhoto);
                                  },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "${account?.firstName ?? ''} ${account?.lastName ?? ''}",
                        style: kTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        account?.email ?? '',
                        style: kTextStyle.copyWith(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                // Subscription status banner
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                          colors: isFree
                              ? [
                                  const Color(0xFF43A047),
                                  const Color(0xFF2E7D32)
                                ]
                              : (subscribed
                                  ? [
                                      const Color(0xFF43A047),
                                      const Color(0xFF2E7D32)
                                    ]
                                  : [
                                      const Color(0xFFF44336),
                                      const Color(0xFFD32F2F)
                                    ]),
                          begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                            color: (isFree || subscribed
                                    ? Colors.green
                                    : Colors.red)
                                .withOpacity(0.3),
                            blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                                isFree
                                    ? CupertinoIcons.checkmark_seal_fill
                                    : (subscribed
                                        ? CupertinoIcons.checkmark_seal_fill
                                        : CupertinoIcons
                                            .exclamationmark_triangle_fill),
                                color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                    isFree
                                        ? AppLocalizations.of(context)!.isFree
                                        : (subscribed
                                            ? AppLocalizations.of(context)!
                                                .activeSubscription
                                            : AppLocalizations.of(context)!
                                                .expiredSubscription),
                                    style: kTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                    isFree
                                        ? AppLocalizations.of(context)!
                                            .appIsFree
                                        : (subscribed
                                            ? "${AppLocalizations.of(context)!.expiresOn} ${DateFormat('dd/MM/yyyy').format(subscriptionDate)}"
                                            : "${AppLocalizations.of(context)!.expiredSince} ${DateFormat('dd/MM/yyyy').format(subscriptionDate)}"),
                                    style: kTextStyle.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                            if (isFree || isSubscriptionExpired)
                              ElevatedButton(
                            onPressed: () {
                                  if (isFree) {
                                    toast(AppLocalizations.of(context)!
                                        .appIsFree);
                                  } else {
                                    toast(AppLocalizations.of(context)!.renew);
                                  }
                                },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                                  foregroundColor:
                                      isFree ? kGreenColor : Colors.red,
                                  elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                                child:
                                    Text(AppLocalizations.of(context)!.renew),
                              ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Information section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Text(
                              AppLocalizations.of(context)!.personalInformation,
                              style: kTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(),
                      _profileInfoTile(
                        icon: Icons.person_outline,
                            title: AppLocalizations.of(context)!.name,
                            value: account?.firstName ?? '',
                            onTap: () =>
                                toast(AppLocalizations.of(context)!.name),
                          ),
                      const Divider(height: 1),
                      _profileInfoTile(
                        icon: Icons.email_outlined,
                            title: AppLocalizations.of(context)!.email,
                            value: account?.email ?? '',
                            onTap: () =>
                                toast(AppLocalizations.of(context)!.email),
                          ),
                      const Divider(height: 1),
                      _profileInfoTile(
                        icon: Icons.phone_outlined,
                            title: AppLocalizations.of(context)!.phone,
                            value: account?.lastName ?? '',
                            onTap: () =>
                                toast(AppLocalizations.of(context)!.phone),
                          ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Actions section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Text(
                              AppLocalizations.of(context)!.actions,
                              style: kTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.password_outlined, color: Colors.blue),
                        ),
                            title: Text(
                                AppLocalizations.of(context)!.changePassword,
                                style: kTextStyle),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => toast(
                                AppLocalizations.of(context)!.changePassword),
                          ),
                      const Divider(height: 1),
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.notifications_outlined, color: Colors.orange),
                        ),
                            title: Text(
                                AppLocalizations.of(context)!
                                    .notificationSettings,
                                style: kTextStyle),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => toast(AppLocalizations.of(context)!
                                .notificationSettings),
                          ),
                      const Divider(height: 1),
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: kRedColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(CupertinoIcons.delete, color: kRedColor),
                        ),
                        title: Text(
                              AppLocalizations.of(context)!.deleteMyAccount,
                              style: kTextStyle.copyWith(color: kRedColor),
                        ),
                        trailing: const Icon(Icons.chevron_right, color: kRedColor),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(AppLocalizations.of(context)!
                                      .confirmDeletion),
                                  content: Text(
                                    AppLocalizations.of(context)!
                                        .confirmDeletionMessage,
                                  ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                      child: Text(
                                          AppLocalizations.of(context)!.cancel),
                                    ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _deleteAccount();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kRedColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                      child: Text(
                                          AppLocalizations.of(context)!.delete),
                                    ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Version and app info
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Text(
                            AppLocalizations.of(context)!.appTitle,
                            style: kTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kMainColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                            AppLocalizations.of(context)!.version,
                            style: kTextStyle.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),

          // Loading overlay
          if (isLoading)
            Container(
              width: context.width(),
              height: context.height(),
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Utils.getLoading(),
              ),
            ),
        ],
      ),
    );
      },
    );
  }

  Widget _profileInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: kMainColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: kMainColor),
      ),
      title: Text(title, style: kTextStyle.copyWith(color: Colors.grey[600], fontSize: 14)),
      subtitle: Text(
        value,
        style: kTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      trailing: const Icon(Icons.edit, size: 20, color: kMainColor),
      onTap: onTap,
    );
  }
}