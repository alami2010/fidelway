// ignore_for_file: library_private_types_in_public_api

import 'package:fidelway/login/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../shared/constant.dart';
import '../shared/utils.dart';

class SelectionType extends StatefulWidget {
  const SelectionType({Key? key}) : super(key: key);

  @override
  _SelectionTypeState createState() => _SelectionTypeState();
}

class _SelectionTypeState extends State<SelectionType> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/welcome2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Utils.getLogoWidget(),
                const SizedBox(
                  height: 100.0,
                ),
                const Image(image: AssetImage("images/premium.png")),
                Text(
                  'Select Your Role',
                  style: kTextStyle.copyWith(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: kMainColor),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      onTap: () {
                        const SignIn().launch(context);
                      },
                      leading: const Image(
                        image: AssetImage('images/premium.png'),
                      ),
                      title: Text(
                        'Business Owner / Admin / HR',
                        style: kTextStyle.copyWith(fontSize: 14.0),
                      ),
                      subtitle: Text(
                        'Enregistrez votre entreprise et commencez l\'assiduité',
                        style: kTextStyle.copyWith(
                            color: kGreyTextColor, fontSize: 12.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: kGreyTextColor),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      onTap: () {
                        const SignIn().launch(context);
                      },
                      leading: const Image(
                        image: AssetImage('images/premium.png'),
                      ),
                      title: Text(
                        'Employé',
                        style: kTextStyle.copyWith(fontSize: 14.0),
                      ),
                      subtitle: Text(
                        'Inscrivez-vous et commencez à marquer votre assiduité',
                        style: kTextStyle.copyWith(
                            color: kGreyTextColor, fontSize: 12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
