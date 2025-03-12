import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final MobileScannerController controller = MobileScannerController();
  String? scannedData;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, cameraEnabled, child) {
                if (cameraEnabled != null) {
                  return const Icon(Icons.camera_rear);
                } else {
                  return const Icon(Icons.camera_front);
                }
              },
            ),
            onPressed: controller.switchCamera,
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, torchState, child) {
                if (torchState == TorchState.off) {
                  return const Icon(Icons.flash_off, color: Colors.grey);
                } else if (torchState == TorchState.on) {
                  return const Icon(Icons.flash_on, color: Colors.yellow);
                } else {
                  return const Icon(Icons.flash_off, color: Colors.grey);
                }
              },
            ),
            onPressed: controller.toggleTorch,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: MobileScanner(
              controller: controller,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  final String? scannedCode = barcodes.first.rawValue;
                  controller.stop();
                  print(scannedCode);
                  if (scannedCode != null) {
                    Navigator.pop(context, scannedCode); // Return scanned code
                  }
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(scannedData ?? 'Scan something!'),
            ),
          ),
        ],
      ),
    );
  }
}
