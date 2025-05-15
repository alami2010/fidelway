import 'package:fidelway/login/sign_in.dart';
import 'package:fidelway/model/APIRest.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isButtonEnabled = false;
  bool isLoading = false;

  void checkFields() {
    setState(() {
      isButtonEnabled = nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          passwordController.text == confirmPasswordController.text &&
          _validateEmail(emailController.text) == null &&
          _validatePhone(phoneController.text) == null;
    });
  }

  String? _validateEmail(String? email) {
    if (email!.isEmpty) return "L'email est requis";
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegex.hasMatch(email)) return "Format d'email invalide";
    return null;
  }

  String? _validatePhone(String? phone) {
    if (phone!.isEmpty) return "Le numéro de téléphone est requis";
    final phoneRegex = RegExp(r'^\d{10,15}$');
    if (!phoneRegex.hasMatch(phone)) return "Format de téléphone invalide";
    return null;
  }

  String? _validatePassword(String? password) {
    if (password!.isEmpty) return "Le mot de passe est requis";
    if (password.length < 8) return "Le mot de passe doit contenir au moins 8 caractères";
    return null;
  }

  String? _validateConfirmPassword(String? confirmPassword) {
    if (confirmPassword!.isEmpty) return "Veuillez confirmer votre mot de passe";
    if (confirmPassword != passwordController.text) return "Les mots de passe ne correspondent pas";
    return null;
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(checkFields);
    emailController.addListener(checkFields);
    phoneController.addListener(checkFields);
    passwordController.addListener(checkFields);
    confirmPasswordController.addListener(checkFields);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Inscription',
          style: kTextStyle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header with logo
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Utils.getLogoWidget(),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Créez votre compte et commencez votre aventure',
                      textAlign: TextAlign.center,
                      style: kTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Form container
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name field
                          buildInputField(
                            controller: nameController,
                            icon: Icons.person_outline,
                            label: 'Nom complet',
                            hint: 'Entrez votre nom complet',
                            textFieldType: TextFieldType.NAME,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Le nom est requis';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Email field
                          buildInputField(
                            controller: emailController,
                            icon: Icons.email_outlined,
                            label: 'Adresse e-mail',
                            hint: 'Entrez votre adresse e-mail',
                            textFieldType: TextFieldType.EMAIL,
                            validator: _validateEmail,
                          ),
                          const SizedBox(height: 16),

                          // Phone field
                          buildInputField(
                            controller: phoneController,
                            icon: Icons.phone_outlined,
                            label: 'Numéro de téléphone',
                            hint: 'Entrez votre numéro de téléphone',
                            textFieldType: TextFieldType.PHONE,
                            validator: _validatePhone,
                          ),
                          const SizedBox(height: 16),

                          // Password field
                          buildPasswordField(
                            controller: passwordController,
                            icon: Icons.lock_outline,
                            label: 'Mot de passe',
                            hint: 'Créez votre mot de passe',
                            obscureText: obscurePassword,
                            onToggleVisibility: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            validator: _validatePassword,
                          ),
                          const SizedBox(height: 16),

                          // Confirm password field
                          buildPasswordField(
                            controller: confirmPasswordController,
                            icon: Icons.lock_outline,
                            label: 'Confirmation du mot de passe',
                            hint: 'Confirmez votre mot de passe',
                            obscureText: obscureConfirmPassword,
                            onToggleVisibility: () {
                              setState(() {
                                obscureConfirmPassword = !obscureConfirmPassword;
                              });
                            },
                            validator: _validateConfirmPassword,
                          ),
                          const SizedBox(height: 30),

                          // Sign up button
                          ButtonGlobal(
                            buttontext: 'S\'inscrire',
                            buttonDecoration: BoxDecoration(
                              color: isButtonEnabled ? kMainColor : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: isButtonEnabled
                                  ? [
                                      BoxShadow(
                                        color: kMainColor.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: const Offset(0, 5),
                                      ),
                                    ]
                                  : null,
                            ),
                            onPressed: isButtonEnabled
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      try {
                                        User user = getUser();
                                        await APIRest.signUp(user);

                                        if (mounted) {
                                    Utils.showSucces(
                                      "Inscription réussie ! Vous pouvez maintenant vous connecter.",
                                      context: context,
                                    );
                                    await Future.delayed(const Duration(seconds: 1));
                                    const SignIn().launch(context);
                                  }
                                } catch (e) {
                                  Utils.showErreur(
                                    "Cette adresse email est déjà utilisée.",
                                    context: context,
                                  );
                                } finally {
                                  if (mounted) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }
                              }
                            }
                                : null,
                            isLoading: isLoading,
                            textColor: isButtonEnabled ? Colors.white : Colors.grey.shade600,
                          ),
                          const SizedBox(height: 24),

                          // Sign in link
                          Center(
                            child: GestureDetector(
                              onTap: () => const SignIn().launch(context),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Vous avez déjà un compte ? ',
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                    TextSpan(
                                      text: 'Se connecter',
                                      style: kTextStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: kMainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required String hint,
    required TextFieldType textFieldType,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        AppTextField(
          textFieldType: textFieldType,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: kTextStyle.copyWith(color: Colors.grey),
            prefixIcon: Icon(icon, color: kMainColor),
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kMainColor, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPasswordField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required String hint,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: kTextStyle.copyWith(color: Colors.grey),
            prefixIcon: Icon(icon, color: kMainColor),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: kGreyTextColor,
              ),
              onPressed: onToggleVisibility,
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kMainColor, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
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