import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../shared/constant.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String policy =
        'Lorem ipsum dolor sit amet, consectetur adip is cing elit. Neque nulla sed mauris feugiat eget. Augue id neque nisl nibh ut facilisis massa, diam. Quam massa in fusce mi faucibus integer est, en im. At sed ante et leo. Erat mattis sed cursus pelle ntesque scelerisque sit. Ullamcorper eros senectus urna sit elementum aliquet. Nibh mauris trist ique elit pellentesque sapien malesuada eleifend iaculis malesuada. Mauris, ut id hendrerit habitant gravida urna congue arcu sit. At quisque leo semper urna gravida iac ulis nibh aliquam. Morbi tempor facilisi ultricies magna vitae sit. Velit augue sagittis, tempor, amet arcu nullam quam. Sit feugiat amet, pellentesque morbi mattis id blandit arcu morbi. Morbi cursus ac tortor amet. Iaculis nunc bibendum in vitae turpis mattis nisl viverra. Turpis habitant purus, venenatis vitae ut urna, rhoncus nunc. Aliquam turpis pellentesque arcu malesuada ut et lorem. Donec tincidunt tristique ultricies sed faucibus. Morbi et eu mi, nec, suscipit. Duis pellentesque facilisi pharetra enim neque sagittis.';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Privacy Policy',
          style: kTextStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
              width: context.width(),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: kBgColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: context.width(),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Privacy Policy',
                          style: kTextStyle.copyWith(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Date Updated” (7 Jun 2021)',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                        Text(
                          policy,
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
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
