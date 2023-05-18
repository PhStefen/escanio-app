import 'package:camera/camera.dart';
import 'package:escanio_app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> with WidgetsBindingObserver {
  CameraController? controller;
  BarcodeScanner? scanner;

  bool _isCameraInitialized = false;

  void initCamera(CameraDescription cameraDescription) async {
    final cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );

    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  void initScanner() {
    scanner = BarcodeScanner(formats: [BarcodeFormat.all]);
  }

  // void processImage(InputImage image) async {
  //   final barcodes = await scanner.processImage(image);

  //   for (Barcode barcode in barcodes) {}
  // }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }
    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller!.setExposurePoint(offset);
    controller!.setFocusPoint(offset);
  }

  @override
  void initState() {
    initCamera(cameras[0]);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;
    final BarcodeScanner? barcodeScanner = scanner;

    if (state == AppLifecycleState.inactive) {
      if (cameraController != null && cameraController.value.isInitialized) {
        cameraController.dispose();
      }
      // barcodeScanner.close();
    } else if (state == AppLifecycleState.resumed) {
      // initCamera(cameraController.description);
      initScanner();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? CameraPreview(
              controller!,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (details) => onViewFinderTap(details, constraints),
                );
              }),
            )
          : Container(),
    );
  }
}
