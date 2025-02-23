import 'package:FidelWay/login/sign_in.dart';
import 'package:FidelWay/model/APIRest.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/user.dart';
import '../shared/button_global.dart';
import '../shared/constant.dart';
import '../shared/utils.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isButtonEnabled = false;
  String? emailError;
  String? phoneError;

  void checkFields() {
    setState(() {
      emailError = _validateEmail(emailController.text);
      phoneError = _validatePhone(phoneController.text);
      isButtonEnabled = nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          emailError == null &&
          phoneError == null;
    });
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return "L'email est requis";
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegex.hasMatch(email)) return "Email invalide";
    return null;
  }

  String? _validatePhone(String phone) {
    if (phone.isEmpty) return "Le numéro de téléphone est requis";
    final phoneRegex = RegExp(r'^\d{10,15}$');
    if (!phoneRegex.hasMatch(phone)) return "Numéro de téléphone invalide";
    return null;
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(checkFields);
    emailController.addListener(checkFields);
    phoneController.addListener(checkFields);
    passwordController.addListener(checkFields);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Connexion',
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/welcome2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(child: Utils.getLogoWidget()),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Inscrivez-vous maintenant pour commencer une aventure incroyable',
                style: kTextStyle.copyWith(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  AppTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This is the required field';
                      }
                      return null;
                    },
                    textFieldType: TextFieldType.NAME,
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nom complet',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  if (nameController.text.isEmpty)
                    const Text(
                      'Le nom est requis',
                      style: nameOfTextStyle,
                    ),
                  const SizedBox(height: 20.0),
                  AppTextField(
                    textFieldType: TextFieldType.EMAIL,
                    controller: emailController,
                    suffix: emailError != null ? Text(emailError!) : null,
                    decoration: const InputDecoration(
                      labelText: 'Adresse e-mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  if (_validateEmail(emailController.text) != null)
                    Text(
                      _validateEmail(emailController.text)!,
                      style: nameOfTextStyle,
                    ),
                  const SizedBox(height: 20.0),
                  AppTextField(
                    textFieldType: TextFieldType.PHONE,
                    controller: phoneController,
                    suffix: phoneError != null ? Text(phoneError!) : null,
                    decoration: InputDecoration(
                      labelText: 'Numéro de téléphone',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  if (phoneError != null)
                    Text(
                      phoneError!,
                      style: nameOfTextStyle,
                    ),
                  const SizedBox(height: 20.0),
                  AppTextField(
                    textFieldType: TextFieldType.PASSWORD,
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ButtonGlobal(
                    buttontext: 'S\'inscrire',
                    buttonDecoration: kButtonDecoration.copyWith(
                        color: isButtonEnabled ? kMainColor : Colors.grey),
                    onPressed: isButtonEnabled
                        ? () {
                            User user = getUser();

                            APIRest.signUp(user).then((value) {
                              const SignIn().launch(context);
                              Utils.showSucces("Bienvue");
                            }).catchError((value) {
                              Utils.showErreur("Email déjà utilisé!");
                            });
                          }
                        : null,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Vous avez déjà un compte ? ',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => const SignIn().launch(context),
                            child: Text(
                              'Se connecter',
                              style: kTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: kMainColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  User getUser() {
    return User(
      login: emailController.text,
      email: emailController.text,
      password: passwordController.text,
      firstName: nameController.text,
      lastName: phoneController.text,
      langKey: 'FR',
      activated: true,
      authorities: Set.of([]),
    );
  }
}
