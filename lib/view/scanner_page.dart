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
        body: StreamBuilder<List<String>>(
          stream: null,
          builder: (context, snapshot) {
            return CustomScrollView(
              slivers: [
            SliverAppBar(
              expandedHeight: 500,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
              title: Text("eba"),
              floating: true,
              stretch: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                background: Column(
                  children: [
                    Expanded(
                      child: Text(""),
                    ),
                    QrScannerWidget<String>(
                      qrValidationService: QrService(),
                      onCodeValidated: print,
                      onError: print,
                    )
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Text("Eba"),
            )
              ],
            );
          }
        ));
  }
}

class QrService extends QrValidationService<String> {
  @override
  Future<String> validateQrCode(String qrCode) async {
    return qrCode;
  }
}
