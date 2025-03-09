// ignore_for_file: library_private_types_in_public_api

import 'package:fidelway/login/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/APIRest.dart';
import '../shared/button_global.dart';
import '../shared/constant.dart';
import '../shared/otp_form.dart';
import '../shared/utils.dart';

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
    print("Received OTP: $otp"); // 🎯 Use OTP here
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
    return Scaffold(
      drawer: Utils.buildDrawer(context),
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Validation de code',
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Merci de remplir le code reçu par mail et le nouveau password.',
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
                      'Code reçu par mail',
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
                      'Renvoyer un nouveau code',
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
                        labelText: 'Nouveau password',

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
                    buttontext: 'Changer le mot de passe',
                    buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                    onPressed: () {
                      startLoading();
                      APIRest.finishPasswordReset(optCode, control.text).then((value) {
                        Utils.showSucces('Mot de pass bien changé');
                        const SignIn().launch(context);
                        stopLoading();
                      }).catchError((value) {
                        Utils.showErreur('Erreur lors de changement de mot de passe');

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
  }
}
