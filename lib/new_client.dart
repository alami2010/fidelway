import 'package:fidelway/shared/constant.dart';
import 'package:fidelway/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'model/APIRest.dart';
import 'shared/local_storage_helper.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});

  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  GlobalKey globalKey = GlobalKey();
  String _dataString = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carte de Fidélité", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kMainColor,
        foregroundColor: Colors.white,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 24),
            _buildForm(),
            const SizedBox(height: 32),
            _buildCreateButton(),
            const SizedBox(height: 40),
            if (_dataString.isNotEmpty) _buildQRSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              Icons.card_membership,
              size: 48,
              color: kMainColor,
            ),
            const SizedBox(height: 16),
            Text(
              "Créez votre carte de fidélité",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kMainColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Remplissez le formulaire ci-dessous pour générer votre QR code personnel",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Informations Personnelles",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              filled: true,
              fillColor: Colors.grey.shade100,
              prefixIcon: Icon(Icons.person, color: kMainColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              labelText: 'Nom Complet',
              hintText: 'Entrez votre nom complet',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre nom';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              filled: true,
              fillColor: Colors.grey.shade100,
              prefixIcon: Icon(Icons.email, color: kMainColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              labelText: 'Email',
              hintText: 'Entrez votre adresse email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre email';
              }
              // Simple email validation
              if (!value.contains('@') || !value.contains('.')) {
                return 'Veuillez entrer un email valide';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _generateAndSaveCard,
      style: ElevatedButton.styleFrom(
        backgroundColor: kMainColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: _isLoading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                const Text("Création en cours..."),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add_card),
                const SizedBox(width: 12),
                const Text(
                  "CRÉER MA CARTE DE FIDÉLITÉ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
    );
  }

  Widget _buildQRSection() {
    return Column(
      children: [
        const Divider(thickness: 1),
        const SizedBox(height: 16),
        Text(
          "Votre QR Code est prêt !",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: kMainColor,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Montrez ce QR code lors de vos visites pour cumuler vos points fidélité",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 24),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                RepaintBoundary(
                  key: globalKey,
                  child: QrImageView(
                    data: _dataString,
                    size: 200,
                    backgroundColor: Colors.white,
                    errorStateBuilder: (context, error) => const Center(
                      child: Text(
                        "Erreur lors de la génération du QR code",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _nameController.text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _emailController.text,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
/*                OutlinedButton.icon(
                  onPressed: _shareQrCode,
                  icon: const Icon(Icons.share),
                  label: const Text("Partager ma carte"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kMainColor,
                    side: BorderSide(color: kMainColor),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _generateAndSaveCard() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final generatedCode = generateCode();

      // Simulate network delay for better UX
      Future.delayed(const Duration(seconds: 1), () {
        APIRest.create(generatedCode, _nameController.text, _emailController.text).then((value) {
          setState(() {
            _dataString = generatedCode;
            _isLoading = false;
          });

          Utils.showSucces("Votre carte de fidélité a bien été créée. Si vous avez renseigné un email, vous la recevrez par email.",
              context: context);
        }).catchError((error) {
          setState(() {
            _isLoading = false;
          });

          Utils.showErreur("Une erreur s'est produite lors de la création de votre carte", context: context);
        });
      });
    }
  }

  /* void _shareQrCode() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      if (boundary.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 20));
        return _shareQrCode(); // retry after paint
      }

      final image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/qr_code.png';
      final file = File(filePath);
      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(filePath)], text: 'Voici ma carte de fidélité QR !');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du partage : $e')),
      );
    }
  }

  Future<void> scanQrCode() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
    );

    if (result != null) {
      setState(() {
        _isLoading = true;
      });

      APIRest.create(result, _nameController.text, _emailController.text).then((value) {
        setState(() {
          _isLoading = false;
        });

        const HomeScreen().launch(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Carte créée avec succès")),
        );
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erreur lors de la création de la carte")),
        );
      });
    }
  }*/

  String generateCode() {
    return "${LocalStorageHelper.getAccount()?.id ?? "_shop_"}_${DateTime.now().microsecondsSinceEpoch}";
  }
}
