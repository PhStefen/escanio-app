import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/components/loading.dart';
import 'package:escanio_app/components/scanned_card.dart';
import 'package:escanio_app/extensions/iterable_extension.dart';
import 'package:escanio_app/models/history_model.dart';
import 'package:escanio_app/models/price_model.dart';
import 'package:escanio_app/models/product_model.dart';
import 'package:escanio_app/services/history_service.dart';
import 'package:escanio_app/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:escanio_app/main.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

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
  bool _isStreaming = false;

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
    final rotation = InputImageRotationValue.fromRawValue(camera!.sensorOrientation);

    if (rotation == null) {
      return null;
    }

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null || format != InputImageFormat.nv21 || image.planes.length != 1) {
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
    if (mounted) {
      setState(() {
        _isStreaming = true;
      });
    }
  }

  Future<void> _resumeLiveFeed() async {
    _cameraController?.startImageStream(_processCameraImage);
    if (mounted) {
      setState(() {
        _isStreaming = true;
      });
    }
  }

  Future<void> _addToHistory(ProductModel product) async {
    var ref = HistoryService.collection.doc(product.id);
    var snapshot = await ref.get();
    HistoryModel history;

    // Updates History
    if (snapshot.exists) {
      history = snapshot.data()!;

      var lastPrice = product.prices.first.value;

      if (lastPrice != history.price) {
        product.prices.insert(0, PriceModel(date: Timestamp.now(), value: lastPrice));
        ProductsService.set(product);
        history.price = lastPrice;
      }
    }

    // Create new History
    else {
      history = HistoryModel(
        id: product.id,
        name: product.name,
        price: product.prices.first.value,
        lastSeen: Timestamp.now(),
        isFavourite: false,
      );
    }

    await ref.set(history);
  }

  Future<void> _processBarCode(InputImage inputImage) async {
    if (!_canProcess || _isBusy) return;
    await _cameraController!.pausePreview();
    setState(() {
      _isBusy = true;
    });
    final barcodes = await _barcodeScanner.processImage(inputImage);

    for (final barcode in barcodes) {
      var code = barcode.rawValue!;

      if (_blockList.contains(code)) {
        continue;
      }
      if (_scanned.any((element) => element.barCode == code)) {
        continue;
      }
      var snapshot = await ProductsService.scan(code);
      var products = snapshot.docs.map((e) => e.data()).toList();
      if (products.isEmpty) {
        _blockList.add(code);
      }

      for (final product in products) {
        await _addToHistory(product);
        _scanned.add(product);
      }
    }

    if (mounted) {
      await _cameraController!.resumePreview();
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

    const previewRatio = 0.8;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              child: AspectRatio(
                aspectRatio: 1 / previewRatio,
                child: ClipRect(
                  child: Transform.scale(
                    scale: _cameraController!.value.aspectRatio / previewRatio,
                    child: Center(
                      child: CameraPreview(_cameraController!),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                reverse: true,
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
          ],
        ),
      ),
    );
  }
}
