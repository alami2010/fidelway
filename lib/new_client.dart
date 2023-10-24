import 'package:FidelWay/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'local_storage_helper.dart';
import 'model/APIRest.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Tabs(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => {},
          )
        ],
      ),
      body: _contentWidget(),
    );
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
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
                    foregroundColor: Colors.yellow,
                    backgroundColor: Colors.black,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  child: Text(" Créer "),
                  onPressed: () {
                    print(LocalStorageHelper.readShopName());

                    setState(() {
                      _dataString = ((LocalStorageHelper.readShopName() ??
                              "shop_")! +
                          DateTime.now().microsecondsSinceEpoch.toString())!;
                      APIRest.create(_dataString, _nameController.text,
                              _telController.text)
                          .then((value) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Bien Créer"),
                        ));
                      });

                      _inputErrorText = "";
                    });
                  },
                ),
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.yellow,
                    backgroundColor: Colors.black,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  child: Text("Enregistrer"),
                  onPressed: () {
                    setState(() {
                      FlutterBarcodeScanner.scanBarcode(
                              "#000000", "Sortir", true, ScanMode.QR)
                          .then((code) {
                        if (code != "-1") {
                          APIRest.create(code, _nameController.text,
                                  _telController.text)
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Bien Enregistrer"),
                            ));
                          });
                        }
                      });
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
}
