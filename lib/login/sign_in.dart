import 'package:fidelway/login/sign_up.dart';
import 'package:fidelway/model/APIRest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../shared/button_global.dart';
import '../shared/constant.dart';
import '../shared/utils.dart';
import 'auth_service.dart';
import 'forgot_password.dart';
import 'login_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final AuthService _authService = AuthService();
  LoginService loginService = LoginService();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Connexion',
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Center(child: Utils.getLogoWidget()),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Connectez-vous maintenant pour commencer une aventure incroyable',
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
                  const SizedBox(height: 20.0),
                  _buildEmailField(),
                  const SizedBox(height: 20.0),
                  _buildPasswordField(),
                  const SizedBox(height: 20.0),
                  _buildRememberMeAndForgotPassword(),
                  const SizedBox(height: 20.0),
                  _buildSignInButton(),
                  const SizedBox(height: 20.0),
                  _buildGoogleSignInButton(),
                  const SizedBox(height: 20.0),
                  if (isLoading) Utils.getLoading(),
                  _buildSignUpText(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return SizedBox(
      height: 60.0,
      child: AppTextField(
        textFieldType: TextFieldType.EMAIL,
        controller: emailController,
        enabled: true,
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: kTextStyle,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return AppTextField(
      textFieldType: TextFieldType.PASSWORD,
      controller: passwordController,
      decoration: InputDecoration(
        labelText: 'Mot de passe',
        labelStyle: kTextStyle,
        hintText: 'Entrez votre mot de passe',
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildRememberMeAndForgotPassword() {
    return Row(
      children: [
        Transform.scale(
          scale: 0.8,
          child: CupertinoSwitch(
            value: isChecked,
            thumbColor: kGreyTextColor,
            onChanged: (bool value) {
              setState(() {
                isChecked = value;
              });
            },
          ),
        ),
        Text('Se souvenir de moi', style: kTextStyle),
        const Spacer(),
        Text('Mot de passe oublié ?', style: kTextStyle).onTap(() {
          const ForgotPassword().launch(context);
        }),
      ],
    );
  }

  Widget _buildSignInButton() {
    return ButtonGlobal(
      buttontext: 'Se connecter',
      buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
      onPressed: () {
        startLoading();

        APIRest.login(emailController.text, passwordController.text).then((value) async {
          await loginService.afterLogin(value, context);

          stopLoading();
        }).catchError((value) {
          stopLoading();
          Utils.showErreur("Login ou mot de passe incorrect");
        });
      },
    );
  }

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  Widget _buildGoogleSignInButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      onPressed: () async {
        startLoading();
        final user = await _authService.signInWithGoogle();

        if (user != null) {
          var token = await user?.getIdToken(true) ?? '';

          await APIRest.validateGoogleToken(token).then((value) async {
            await loginService.afterLogin(value, context);
            stopLoading();
          }).catchError((error) {
            stopLoading();
          });
        } else {
          stopLoading();
        }
      },
      child: const Padding(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/images/google_logo.png"),
              height: 18.0,
              width: 24,
            ),
            Padding(
              padding: EdgeInsets.only(left: 24, right: 8),
              child: Text(
                'Se connecter avec Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  Widget _buildSignUpText() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Vous n\'avez pas de compte ? ',
            style: kTextStyle.copyWith(color: kGreyTextColor),
          ),
          WidgetSpan(
            child: Text(
              'Inscrivez-vous',
              style: kTextStyle.copyWith(fontWeight: FontWeight.bold, color: kMainColor),
            ).onTap(() {
              const Inscription().launch(context);
            }),
          ),
        ],
      ),
    );
  }
}
