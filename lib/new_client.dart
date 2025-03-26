import 'package:fidelway/shared/constant.dart';
import 'package:fidelway/shared/utils.dart';
import 'package:fidelway/subscribtion/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'home.dart';
import 'model/APIRest.dart';
import 'shared/local_storage_helper.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});

  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  GlobalKey globalKey = new GlobalKey();
  String _dataString = "";
  late String _inputErrorText;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _telController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _contentWidget();
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nom Complet *',
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _telController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email  *',
                ),
              )
            ]),
          ),
          Row(
            children: [
              SizedBox(
                height: 50,
                width: 150,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: kMainColor,
                    backgroundColor: kMainColor,
                    shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  child: const Text("Créer votre carte de fidélité "),
                  onPressed: () {
                    setState(() {
                      _dataString = generateCode();
                      APIRest.create(_dataString, _nameController.text, _telController.text).then((value) {
                        Utils.showSucces("Votre carte de fidélité a bien été créée. Si vous avez renseigné un email, vous la recevrez par email.",
                            context: context);
                      });

                      _inputErrorText = "";
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (_dataString.isNotEmpty)
            Expanded(
              child: Center(
                child: RepaintBoundary(
                  key: globalKey,
                  child: QrImageView(
                    data: _dataString,
                    size: 0.5 * bodyHeight,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> scanQrCode() async {
    /*APIRest.scan("test_21-10-00000x3x").then((value) {
      setState(() {
        // adding a new marker to map
        client = value;
      });
    });*/

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
    );

    if (result != null) {
      APIRest.create(result, _nameController.text, _telController.text).then((value) {
        const HomeScreen().launch(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Bien Créer"),
        ));
      });
    }
  }

  String generateCode() {
    return ("${LocalStorageHelper.getAccount()?.id ?? "_shop_"}_${DateTime.now().microsecondsSinceEpoch}");
  }
}
