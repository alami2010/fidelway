import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nb_utils/nb_utils.dart';

import '../shared/constant.dart';
import '../shared/menu.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          AppLocalizations.of(context)!.privacyPolicy,
          style: kTextStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Container(
        width: context.width(),
        decoration: const BoxDecoration(
          color: kBgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 60,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.privacyPolicyTitle,
                        style: kTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.effectiveDate,
                        style: kTextStyle.copyWith(
                          fontSize: 14,
                          color: kGreyTextColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _sectionTitle(AppLocalizations.of(context)!.introduction),
                      _sectionText(
                          AppLocalizations.of(context)!.introductionText),
                      const SizedBox(height: 12),
                      _sectionTitle(
                          AppLocalizations.of(context)!.dataWeCollect),
                      _sectionText(
                          AppLocalizations.of(context)!.dataWeCollectText),
                      const SizedBox(height: 12),
                      _sectionTitle(AppLocalizations.of(context)!.dataUsage),
                      _sectionText(AppLocalizations.of(context)!.dataUsageText),
                      const SizedBox(height: 12),
                      _sectionTitle(
                          AppLocalizations.of(context)!.sharingAndSecurity),
                      _sectionText(
                          AppLocalizations.of(context)!.sharingAndSecurityText),
                      const SizedBox(height: 12),
                      _sectionTitle(AppLocalizations.of(context)!.yourRights),
                      _sectionText(
                          AppLocalizations.of(context)!.yourRightsText),
                      const SizedBox(height: 12),
                      _sectionTitle(AppLocalizations.of(context)!.contact),
                      _sectionText(AppLocalizations.of(context)!.contactText),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: kTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _sectionText(String content) {
    return Text(
      content,
      style: kTextStyle.copyWith(
        fontSize: 14,
        height: 1.5,
        color: kGreyTextColor,
      ),
    );
  }
}
