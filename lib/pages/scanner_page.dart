import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/components/loading.dart';
import 'package:escanio_app/components/scanned_card.dart';
import 'package:escanio_app/models/history_model.dart';
import 'package:escanio_app/models/price_model.dart';
import 'package:escanio_app/models/product_model.dart';
import 'package:escanio_app/services/history_service.dart';
import 'package:escanio_app/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:escanio_app/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'dart:math';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final _scanned = <ProductModel>[];
  final _blockList = <String>[];

  final _barcodeScanner = BarcodeScanner();
  bool _canProcess = true;
  bool _isBusy = false;

  CameraController? _cameraController;
  CameraDescription? camera;

  @override
  void initState() {
    super.initState();
    camera = cameras[0];
    _startLiveFeed();
  }

  @override
  void dispose() {
    _canProcess = false;
    _barcodeScanner.close();
    super.dispose();
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    final rotation =
        InputImageRotationValue.fromRawValue(camera!.sensorOrientation);

    if (rotation == null) {
      return null;
    }

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null ||
        format != InputImageFormat.nv21 ||
        image.planes.length != 1) {
      return null;
    }

    final plane = image.planes.first;
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(
          image.width.toDouble(),
          image.height.toDouble(),
        ),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    _processBarCode(inputImage);
  }

  Future<void> _startLiveFeed() async {
    _cameraController = CameraController(
      camera!,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.nv21,
    );
    await _cameraController?.initialize();
    _resumeLiveFeed();
  }

  Future<void> _pauseLiveFeed() async {
    _cameraController?.stopImageStream();
  }

  Future<void> _resumeLiveFeed() async {
    _cameraController?.startImageStream(_processCameraImage);
  }

  Future<void> _addToHistory(ProductModel product) async {
    var ref = HistoryService.collection.doc(product.id);
    var snapshot = await ref.get();
    HistoryModel history;

    // Updates History
    if (snapshot.exists) {
      history = snapshot.data()!;
      history.lastSeen = Timestamp.now();

      var lastPrice = product.prices.first.value;
      Map<String, dynamic> updateValues = {"lastSeen": Timestamp.now()};

      if (lastPrice != history.price) {
        product.prices
            .insert(0, PriceModel(date: Timestamp.now(), value: lastPrice));
        ProductsService.collection
            .doc(product.id)
            .update({"prices": product.prices});
        updateValues["price"] = lastPrice;
      }

      await ref.update(updateValues);
      return;
    }

    // Create new History
    history = HistoryModel(
      id: product.id,
      name: product.name,
      price: product.prices.first.value,
      lastSeen: Timestamp.now(),
      isFavourite: false,
    );

    await ref.set(history);
  }

  Future<void> _processBarCode(InputImage inputImage) async {
    if (!_canProcess || _isBusy) return;
    await _cameraController!.pausePreview();
    if (mounted) {
      setState(() {
        _isBusy = true;
      });
    }
    final barcodes = await _barcodeScanner.processImage(inputImage);

    for (final barcode in barcodes) {
      var code = barcode.rawValue!;

      if (_blockList.contains(code)) {
        continue;
      }
      var snapshot = await ProductsService.scan(code);
      var products = snapshot.docs.map((e) => e.data()).toList();
      if (products.isEmpty) {
        _blockList.add(code);
      }

      //Sorteio - A Garrafa do Pedro
      final pessoa = [
        "ANA NICOLLY BERNARDELI FEDIRISSI DASCENZIO",
        "ANTONIO AUGUSTO BOGAZ CABEÇO",
        "BRUNO GARCIA GONCALVES",
        "CHRISTOPHER SEIJI TAKAHASHI",
        "DANIEL BARROS SILVA",
        "DANIELA VERARDI MADLUM",
        "GABRIEL AFONSO CASADO ARRAIS",
        "GABRIEL BONIL DA SILVA",
        "GABRIEL VITURI TOZATO",
        "HUGO GONCALVES DE MACEDO",
        "HUGO MIYAMOTO",
        "JONATHAN GARCIA SPEÇAMILLIO",
        "JULIANA APARECIDA DE SOUZA COSTA",
        "LARA SELENA GONCALVES SCARANELLO",
        "LEONARDO ALVES CALDEIRA",
        "LUAN VINICIUS SIMÃO",
        "LUCAS ALIXAME",
        "LUCAS RIBEIRO DE SOUZA",
        "LUCAS RODRIGO DOS SANTOS DE OLIVEIRA",
        "MATHEUS VITTOREL OBA",
        "MOISES CAMILO BRAMBILLA CORREA",
        "NICOLAS GONÇALVES VELLO",
        "NICOLAS VARGAS GUIMARAES",
        "PEDRO HENRIQUE RODRIGUES SOLDERA",
        "PEDRO HENRIQUE SIQUEIRA DA SILVA",
        "RAPHAEL STEFEN BARRETO",
        "RICARDO MORAES GONCALVES JUNIOR",
        "SAMUEL LUIS GOMES",
        "SAMUEL MELEGATTI SCAVASSA",
        "TAYLOR RAYAN DE ARAUJO FERNANDES",
        "THALIS URIEL CHOEIRI MICHELINO",
        "THIAGO DE CARVALHO REGIS",
        "VINICIUS GUIMARAES DOS SANTOS",
        "VIVIAN RODRIGUES NADOTI",
      ];

      final destino = Random().nextInt(pessoa.length);

      if (code.toString() == "7891098040848") {
        if (!_blockList.contains(code)) {
          _blockList.add(code);
        }
        _scanned.insert(
            0,
            ProductModel(
                id: "7891098040848",
                name: pessoa[destino].toString(),
                prices: [PriceModel(date: Timestamp.now(), value: 999.99)],
                barCode: "7891098040848"));
        continue;
      }

      for (final product in products) {
        await _addToHistory(product);
        _scanned.insert(0, product);
        _blockList.add(product.barCode);
      }
    }

    await _cameraController!.resumePreview();
    if (mounted) {
      setState(() {
        _isBusy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController?.value.isInitialized == false) {
      return const Loading();
    }

    const previewRatio = .7;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1 / previewRatio,
                  child: ClipRect(
                    child: Transform.scale(
                      scale:
                          _cameraController!.value.aspectRatio / previewRatio,
                      child: Center(
                        child: CameraPreview(_cameraController!),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: SvgPicture.asset(
                        "images/scanner_layout.svg",
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary,
                            BlendMode.srcIn),
                        width: double.infinity,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: _scanned.length,
                  itemBuilder: (context, index) {
                    return ScannedCard(
                      product: _scanned.elementAt(index),
                      onDismiss: _resumeLiveFeed,
                      onShow: _pauseLiveFeed,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
