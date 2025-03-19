import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadImageModal extends StatelessWidget {
  final String imageUrl;
  final VoidCallback closeModal;

  const DownloadImageModal({
    required this.imageUrl,
    required this.closeModal,
  });

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(imageUrl))) {
      throw Exception('Impossible d\'ouvrir l\'URL $imageUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Télécharger l\'image'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(imageUrl, width: 200, height: 200), // Afficher l'image
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _launchUrl(),
            child: Text('Télécharger l\'image'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: closeModal,
          child: Text('Fermer'),
        ),
      ],
    );
  }
}
