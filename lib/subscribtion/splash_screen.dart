// ignore_for_file: use_build_context_synchronously

import 'package:FidelWay/home.dart';
import 'package:FidelWay/login/sign_in.dart';
import 'package:FidelWay/model/APIRest.dart';
import 'package:FidelWay/shared/local_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../shared/constant.dart';
import '../shared/utils.dart';
import 'on_board.dart';

// ignore_for_file: library_private_types_in_public_api
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    defaultBlurRadius = 10.0;
    defaultSpreadRadius = 0.5;
    bool isOnboardShown = LocalStorageHelper.getOboarding();

    finish(context);
    if (!isOnboardShown) {
      const OnBoard().launch(context, isNewTask: true);
    } else {
      try {
        await APIRest.getAcount();
        setState(() {
          isLoading = false;
        });
        const HomeScreen().launch(context, isNewTask: true);
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        const SignIn().launch(context, isNewTask: true);
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            Utils.getLogoWidget(),
            const Spacer(),
            if (isLoading) Utils.getLoading(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Version 1.0.0',
                  style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
