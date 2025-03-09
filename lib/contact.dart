import 'package:fidelway/shared/local_storage_helper.dart';
import 'package:fidelway/shared/utils.dart';
import 'package:flutter/material.dart';

import '../model/APIRest.dart';
import '../shared/button_global.dart';
import '../shared/constant.dart';

typedef OnSubmitCallback = void Function(String subject, String message, String phone, String email);

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  var account = LocalStorageHelper.getAccount();

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isButtonEnabled = false;
  bool isLoading = false;

  void startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  void checkFields() {
    setState(() {
      isButtonEnabled = subjectController.text.isNotEmpty && messageController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    subjectController.addListener(checkFields);
    messageController.addListener(checkFields);
    phoneController.addListener(checkFields);
    emailController.addListener(checkFields);
    emailController.text = account?.email;
  }

  Future<void> sendContactRequest() async {
    try {
      startLoading();
      await APIRest.sendContact(
        subject: subjectController.text,
        message: messageController.text,
        phone: phoneController.text,
        email: emailController.text,
      );
      stopLoading();
      Utils.showSucces("Message envoyé avec succès !");
    } catch (e) {
      stopLoading();
      Utils.showErreur("Échec de l'envoi du message !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("Nous contacter", style: kTextStyle.copyWith(color: Colors.white)),
      ),
      drawer: Utils.buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Numéro de téléphone', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(labelText: 'Sujet *', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: messageController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Message *', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            if (isLoading) Utils.getLoading(),
            const SizedBox(height: 20),
            ButtonGlobal(
              buttontext: 'Envoyer',
              buttonDecoration: kButtonDecoration.copyWith(color: isButtonEnabled ? kMainColor : Colors.grey),
              onPressed: isButtonEnabled ? sendContactRequest : null,
            ),
          ],
        ),
      ),
    );
  }
}
