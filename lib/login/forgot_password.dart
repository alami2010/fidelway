// import 'package:country_code_picker/country_code_picker.dart';
// ignore_for_file: library_private_types_in_public_api

import 'package:fidelway/login/phone_verification.dart';
import 'package:fidelway/model/APIRest.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../shared/button_global.dart';
import '../shared/constant.dart';
import '../shared/utils.dart';
import '../shared/language_provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController control = TextEditingController();
  bool isLoading = false;

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  void startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
              AppLocalizations.of(context)!.forgotPasswordTitle,
              style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
                  AppLocalizations.of(context)!.forgotPasswordDescription,
                  style: kTextStyle.copyWith(color: Colors.white),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 60.0,
                    child: AppTextField(
                      textFieldType: TextFieldType.EMAIL,
                      controller: control,
                      enabled: true,
                      decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.email,

                            labelStyle: kTextStyle,
                        border: const OutlineInputBorder(),
                        // prefixIcon: CountryCodePicker(
                        //   padding: EdgeInsets.zero,
                        //   onChanged: print,
                        //   initialSelection: 'BD',
                        //   showFlag: true,
                        //   showDropDownButton: true,
                        //   alignLeft: false,
                        // ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (isLoading) Utils.getLoading(),
                  if (isLoading)
                    const SizedBox(
                      height: 20.0,
                    ),
                  ButtonGlobal(
                        buttontext: AppLocalizations.of(context)!.receiveCode,
                        buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                    onPressed: () {
                      startLoading();
                      APIRest.requestPasswordReset(control.text).then((value) {
                            Utils.showSucces(
                                AppLocalizations.of(context)!
                                    .codeSentSuccessfully,
                                context: context);
                            const PhoneVerification().launch(context);
                        stopLoading();
                      }).catchError((value) {
                            Utils.showErreur(
                                AppLocalizations.of(context)!.errorSendingEmail,
                                context: context);

                            stopLoading();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
      },
    );
  }
}
