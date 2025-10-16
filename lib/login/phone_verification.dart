// ignore_for_file: library_private_types_in_public_api

import 'package:fidelway/login/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../model/APIRest.dart';
import '../shared/button_global.dart';
import '../shared/constant.dart';
import '../shared/otp_form.dart';
import '../shared/utils.dart';
import '../shared/language_provider.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({Key? key}) : super(key: key);

  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  TextEditingController control = TextEditingController();
  bool isLoading = false;
  String optCode = '';

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  void handleOtp(String otp) {
    // 🎯 Use OTP here
    setState(() {
      optCode = otp;
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
              AppLocalizations.of(context)!.codeValidation,
              style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
                  AppLocalizations.of(context)!.codeValidationDescription,
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
                  Container(
                    width: context.width(),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: const Border(
                          left: BorderSide(
                        color: kAlertColor,
                        width: 3.0,
                      )),
                      color: kAlertColor.withOpacity(0.1),
                    ),
                    child: Text(
                          AppLocalizations.of(context)!.codeReceivedByEmail,
                          style: kTextStyle.copyWith(color: kTitleColor, fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  OtpForm(onOtpCompleted: handleOtp),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: kButtonDecoration.copyWith(color: kTitleColor.withOpacity(0.1)),
                    child: Text(
                          AppLocalizations.of(context)!.resendNewCode,
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 60.0,
                    child: AppTextField(
                      textFieldType: TextFieldType.PASSWORD,
                      controller: control,
                      enabled: true,
                      decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.newPassword,

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
                        buttontext:
                            AppLocalizations.of(context)!.changePassword,
                        buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                    onPressed: () {
                      startLoading();
                      APIRest.finishPasswordReset(optCode, control.text).then((value) {
                            Utils.showSucces(
                                AppLocalizations.of(context)!
                                    .passwordChangedSuccessfully,
                                context: context);
                            const SignIn().launch(context);
                        stopLoading();
                      }).catchError((value) {
                            Utils.showErreur(
                                AppLocalizations.of(context)!
                                    .errorChangingPassword,
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
