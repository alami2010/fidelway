import 'dart:io';

import 'package:fidelway/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../model/APIRest.dart';
import 'constant.dart';
import 'language_provider.dart';

class DownloadImageModal extends StatefulWidget {
  final VoidCallback closeModal;

  const DownloadImageModal({
    Key? key,
    required this.closeModal,
  }) : super(key: key);

  @override
  State<DownloadImageModal> createState() => _DownloadImageModalState();
}

class _DownloadImageModalState extends State<DownloadImageModal> with SingleTickerProviderStateMixin {
  bool isLoading = false;
  String url = "";
  bool isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

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
    try {
      if (!await launchUrl(Uri.parse(url))) {
        throw Exception(
            '${AppLocalizations.of(context)!.unableToOpenUrl} $url');
      }
    } catch (e) {
      Utils.showErreur('${AppLocalizations.of(context)!.errorOpeningLink}: $e',
          context: context);
    }
  }

  Future<void> _copyLinkToClipboard() async {
    await Clipboard.setData(ClipboardData(text: url));
    Utils.showSucces(AppLocalizations.of(context)!.linkCopiedToClipboard,
        context: context);
  }

  Future<void> _shareFlyer() async {
    try {
      // Download the image first
      final response = await http.get(Uri.parse(url));
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/flyer_fidelway.png');
      await file.writeAsBytes(response.bodyBytes);

      // Share the file
      //await Share.shareFiles([file.path], text: 'Scannez ce QR code pour créer votre carte de fidélité');
    } catch (e) {
      Utils.showErreur('${AppLocalizations.of(context)!.errorSharing}: $e',
          context: context);
    }
  }

  Future<void> _loadFlyer() async {
    startLoading();
    try {
      String newUrl = await APIRest.generateFlyer() ?? '';
      setState(() {
        url = newUrl;
      });

      Utils.showSucces(AppLocalizations.of(context)!.flyerGeneratedSuccessfully,
          context: context);
    } catch (e) {
      widget.closeModal();
      Utils.showErreur(AppLocalizations.of(context)!.errorGeneratingFlyer,
          context: context);
    } finally {
      stopLoading();
    }
  }

  Future<void> _regenerateFlyer() async {
    await _loadFlyer();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await _loadFlyer();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Dialog(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      backgroundColor: kMainColor,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kMainColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                          AppLocalizations.of(context)!.loyaltyQrCode,
                          style: kTextStyle.copyWith(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: widget.closeModal,
                        tooltip: AppLocalizations.of(context)!.close,
                      ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Instructions
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: kAlertColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: kMainColorLight.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: kMainColorLight,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                      AppLocalizations.of(context)!
                                          .instructions,
                                      style: kTextStyle,
                                ),
                              ),
                              InkWell(
                                onTap: toggleExpand,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                          isExpanded
                                              ? AppLocalizations.of(context)!
                                                  .reduce
                                              : AppLocalizations.of(context)!
                                                  .seeMore,
                                          style: TextStyle(
                                        color: kMainColorLight,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Icon(
                                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                      color: kMainColorLight,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizeTransition(
                            sizeFactor: _animation,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                    AppLocalizations.of(context)!
                                        .qrCodeInstructions,
                                    style: kTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // QR Code display
                    Container(
                      width: 240,
                      height: 240,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      padding: const EdgeInsets.all(12),
                      child: isLoading
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                    color: kMainColor,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                        AppLocalizations.of(context)!
                                            .generatingQrCode,
                                        style: kTextStyle,
                                  ),
                                ],
                              ),
                            )
                          : url.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    url,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.contain,
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: progress.expectedTotalBytes != null
                                              ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                                              : null,
                                          color: kMainColor,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.broken_image,
                                            size: 50,
                                            color: kRedColor,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                                AppLocalizations.of(context)!
                                                    .unableToLoadImage,
                                                style: TextStyle(color: kRedColor),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),

            // Action buttons
            Container(
              decoration: BoxDecoration(
                color: kMainColorLight,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ActionButton(
                        icon: Icons.refresh,
                            label: AppLocalizations.of(context)!.regenerate,
                            onPressed: _regenerateFlyer,
                        color: kTitleColor,
                      ),
                      _ActionButton(
                        icon: Icons.download,
                            label: AppLocalizations.of(context)!.download,
                            onPressed: _launchUrl,
                        color: kTitleColor,
                      ),
                      _ActionButton(
                        icon: Icons.copy,
                            label: AppLocalizations.of(context)!.copyLink,
                            onPressed: _copyLinkToClipboard,
                        color: kTitleColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: color),
            tooltip: label,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: kTitleColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}