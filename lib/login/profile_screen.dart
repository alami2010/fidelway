// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:fidelway/login/sign_in.dart';
import 'package:fidelway/model/APIRest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../shared/constant.dart';
import '../shared/local_storage_helper.dart';
import '../shared/menu.dart';
import '../shared/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var account = LocalStorageHelper.getAccount();
  bool isLoading = false;

  get resetSelection => null;

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

  Future<void> _deleteAccount() async {
    startLoading();
    await APIRest.delete().then((value) {
      const SignIn().launch(context);
      Utils.showSucces(' Suppression réussie, déconnecter l \'utilisateur', context: context);
      stopLoading();
    }).catchError((error) {
      stopLoading();
      Utils.showErreur(' Erreur lors de la suppression du compte', context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var subscribed = account?.subscribed ?? false;
    return Scaffold(
      drawer: MyDrawer(),
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Profile',
          maxLines: 2,
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          Expanded(
            child: Container(
              width: context.width(),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  AppTextField(
                    readOnly: true,
                    textFieldType: TextFieldType.NAME,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: account?.firstName,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  AppTextField(
                    readOnly: true,
                    textFieldType: TextFieldType.EMAIL,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: account?.email,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  AppTextField(
                    readOnly: true,
                    textFieldType: TextFieldType.PHONE,
                    decoration: InputDecoration(
                      labelText: 'Tél',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: account?.lastName,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: context.width() * 0.95,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: (subscribed) ? kGreenColor : kRedColor,
                          width: 10.0,
                        ),
                      ),
                      color: const Color(0xFFDAF3FF),
                    ),
                    child: ListTile(
                      leading: Icon(
                        (subscribed) ? CupertinoIcons.timer_fill : CupertinoIcons.time,
                        color: (subscribed) ? kGreenColor : kRedColor,
                      ),
                      title: Text(
                        (subscribed) ? "Votre abonnement est Actif" : "Votre abonnement est Expiré",
                        maxLines: 2,
                        style: kTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        (subscribed)
                            ? "Votre abonnement expire le ${DateFormat('dd/MM/yyyy').format(account?.subscriptionExpiryDate ?? DateTime.now())}"
                            : "Votre abonnement est expiré la date ${DateFormat('yyyy-MM-dd').format(account?.subscriptionExpiryDate ?? DateTime.now())}",
                        maxLines: 2,
                        style: kTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: context.width() * 0.95,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: kRedColor,
                          width: 10.0,
                        ),
                      ),
                      color: Color(0xFFDAF3FF),
                    ),
                    child: ListTile(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirmer la suppression'),
                            content: const Text('Êtes-vous sûr de vouloir supprimer votre compte ? Cette action est irréversible.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Annuler'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _deleteAccount();
                                },
                                child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                      },
                      leading: const Icon(
                        CupertinoIcons.delete_solid,
                        color: kRedColor,
                      ),
                      title: Text(
                        "Supprimer mon compte",
                        maxLines: 2,
                        style: kTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (isLoading) Utils.getLoading(),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
