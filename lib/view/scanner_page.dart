import 'package:flutter/material.dart';
import 'package:widget_toolkit_qr/widget_toolkit_qr.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Escaneie um produto")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            QrScannerWidget<String>(
              qrValidationService: QrService(),
              onCodeValidated: print,
              onError: print,
            ),
          ],
        ),
      ),
    );
  }
}

class QrService extends QrValidationService<String> {
  @override
  Future<String> validateQrCode(String qrCode) async {
    return qrCode;
  }
}
