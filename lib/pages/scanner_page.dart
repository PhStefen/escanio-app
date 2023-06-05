import 'package:camera/camera.dart';
import 'package:escanio_app/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:escanio_app/main.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> with WidgetsBindingObserver {
  final _barcodeScanner = BarcodeScanner();
  bool _canProcess = true;
  bool _isBusy = false;

  CameraController? _cameraController;
  CameraDescription? camera;

  @override
  void initState() {
    super.initState();
    camera = cameras[0];
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
      print(barcode.rawValue);
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
    return Scaffold(
      body: SafeArea(
        child: Placeholder(),
      ),
    );
  }
}
