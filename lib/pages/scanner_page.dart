import 'package:camera/camera.dart';
import 'package:escanio_app/components/loading.dart';
import 'package:escanio_app/extensions/iterable_extension.dart';
import 'package:escanio_app/models/product_model.dart';
import 'package:escanio_app/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:escanio_app/main.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final _scanned = <ProductModel>[];

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

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess || _isBusy) return;
    setState(() {
      _isBusy = true;
    });
    final barcodes = await _barcodeScanner.processImage(inputImage);

    for (final barcode in barcodes) {
      if (_scanned.any((element) => element.barCode == barcode.rawValue!)) {
        continue;
      }
      print(_scanned);
      var snapshot = await ProductsService.scan(barcode.rawValue!);
      var products = snapshot.docs.map((e) => e.data()).toList();
      print(products);
      print(barcode.rawValue!);
      _scanned.addAll(products);
    }

    if (mounted) {
      setState(() {
        _isBusy = false;
      });
    }
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
    _processImage(inputImage);
  }

  Future<void> _startLiveFeed() async {

    _cameraController = CameraController(
      camera!,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.nv21,
    );
    await _cameraController?.initialize();
    _cameraController?.startImageStream(_processCameraImage);
    if (mounted) {
      setState(() {});
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
            AspectRatio(
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
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _scanned.length,
                itemBuilder: (context, index) {
                  return Text(_scanned.elementAtOrNull(index)?.name ?? "eba");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
