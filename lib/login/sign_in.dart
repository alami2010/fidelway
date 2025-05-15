import 'package:fidelway/login/sign_up.dart';
import 'package:fidelway/model/APIRest.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final AuthService _authService = AuthService();
  LoginService loginService = LoginService();
  bool rememberMe = false;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            _buildBackgroundDecoration(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildHeader(),
                    const SizedBox(height: 30),
                    _buildLoginForm(size),
                    const SizedBox(height: 15),
                    _buildOrDivider(),
                    const SizedBox(height: 15),
                    _buildSocialLoginButtons(),
                    const SizedBox(height: 15),
                    _buildSignUpText(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(child: Utils.getLoading()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundDecoration() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 220,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        Text(
          'Connexion',
          style: kTextStyle.copyWith(
            color: kMainColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Utils.getLogoWidget(),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Bienvenue',
          style: kTextStyle.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: kMainColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Connectez-vous pour découvrir toutes nos fonctionnalités',
          textAlign: TextAlign.center,
          style: kTextStyle.copyWith(
            color: kGreyTextColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(Size size) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 16),
            _buildRememberMeAndForgotPassword(),
            const SizedBox(height: 30),
            _buildSignInButton(size),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: kTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre email';
            }
            if (!value.contains('@')) {
              return 'Veuillez entrer un email valide';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Entrez votre adresse email',
            hintStyle: kTextStyle.copyWith(color: kGreyTextColor.withOpacity(0.5)),
            prefixIcon: Icon(Icons.email_outlined, color: kMainColor),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: kMainColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.05),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mot de passe',
          style: kTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: passwordController,
          obscureText: !_passwordVisible,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre mot de passe';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Entrez votre mot de passe',
            hintStyle: kTextStyle.copyWith(color: kGreyTextColor.withOpacity(0.5)),
            prefixIcon: Icon(Icons.lock_outline, color: kMainColor),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: kGreyTextColor,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: kMainColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.05),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildRememberMeAndForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: rememberMe,
                activeColor: kMainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (bool? value) {
                  setState(() {
                    rememberMe = value ?? false;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Se souvenir de moi',
              style: kTextStyle.copyWith(fontSize: 14),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            const ForgotPassword().launch(context);
          },
          child: Text(
            'Mot de passe oublié ?',
            style: kTextStyle.copyWith(
              color: kMainColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton(Size size) {
    return SizedBox(
      width: size.width,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kMainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _handleSignIn();
          }
        },
        child: Text(
          'Se connecter',
          style: kTextStyle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: kGreyTextColor.withOpacity(0.3),
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OU',
            style: kTextStyle.copyWith(
              color: kGreyTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: kGreyTextColor.withOpacity(0.3),
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginButtons() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
      ),
      onPressed: _handleGoogleSignIn,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/images/google_logo.png"),
              height: 24.0,
              width: 24,
            ),
            const SizedBox(width: 16),
            Text(
              'Se connecter avec Google',
              style: kTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpText() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Vous n\'avez pas de compte ? ',
              style: kTextStyle.copyWith(color: kGreyTextColor),
            ),
            WidgetSpan(
              child: Text(
                'Inscrivez-vous',
                style: kTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kMainColor,
                ),
              ).onTap(() {
                const Inscription().launch(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSignIn() {
    setState(() {
      isLoading = true;
    });

    APIRest.login(emailController.text, passwordController.text).then((value) async {
      await loginService.afterLogin(value, context);
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      Utils.showErreur("Login ou mot de passe incorrect", context: context);
    });
  }

  void _handleGoogleSignIn() async {
    setState(() {
      isLoading = true;
    });

    final user = await _authService.signInWithGoogle();

    if (user != null) {
      var token = await user.getIdToken(true) ?? '';

      await APIRest.validateGoogleToken(token).then((value) async {
        await loginService.afterLogin(value, context);
        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
        setState(() {
          isLoading = false;
        });
        Utils.showErreur("Erreur lors de la connexion avec Google", context: context);
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
