import 'package:fidelway/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/APIRest.dart';

class DownloadImageModal extends StatefulWidget {
  final VoidCallback closeModal;

  const DownloadImageModal({
    required this.closeModal,
  });

  @override
  State<DownloadImageModal> createState() => _DownloadImageModalState();
}

class _DownloadImageModalState extends State<DownloadImageModal> {
  bool isLoading = false;
  String url = "";

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  void startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Impossible d\'ouvrir l\'URL ${url}');
    }
  }

  Future<void> _loadFlyer() async {
    startLoading();
    try {
      String newUrl = await APIRest.generateFlyer() ?? '';
      setState(() {
        url = newUrl;
      });

      Utils.showSucces('Flyer généré avec succès', context: context);
    } catch (e) {
      widget.closeModal();
      Utils.showErreur('Erreur lors de la génération du flyer', context: context);
    } finally {
      stopLoading();
    }
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await _loadFlyer();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Imprimez et mettez à disposition des clients pour scanner et générer leur carte de fidélité'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLoading) Utils.getLoading(),
          if (url.isNotEmpty)
            Image.network(
              url,
              width: 200,
              height: 200,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Image is loaded
                } else {
                  return Center(
                    child: Utils.getLoading(),
                  ); // Show loading indicator
                }
              },
            ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => _launchUrl(),
          child: Text('Télécharger l\'image'),
        ),
        TextButton(
          onPressed: widget.closeModal,
          child: Text('Fermer'),
        ),
      ],
    );
  }
}
