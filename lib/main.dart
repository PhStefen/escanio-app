import 'package:camera/camera.dart';
import 'package:escanio_app/extensions/color_extension.dart';
import 'package:escanio_app/extensions/context_extension.dart';
import 'package:escanio_app/extensions/material_color_extension.dart';
import 'package:escanio_app/pages/home_page.dart';
import 'package:escanio_app/pages/login_page.dart';
import 'package:escanio_app/pages/scanner_page.dart';
import 'package:escanio_app/services/auth_service.dart';
import 'package:escanio_app/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<CameraDescription> cameras = [];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool showSplash = true;

  Future initFirebase() async {
    await FirebaseService.init();
  }

  Future initAuth() async {
    await AuthService.init();
  }

  Future initCameras() async {
    cameras = await availableCameras();
  }

  Future init() async {
    await initFirebase();
    await initAuth();
    await initCameras();
    setState(() {
      showSplash = false;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSwatch(
      primarySwatch: MaterialColorExtension.fromColor(
        ColorExtension.fromHex("#CB3232"),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Escânio",
      theme: ThemeData.light().copyWith(
        colorScheme: colorScheme,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color.fromRGBO(27, 30, 35, 0.76),
      ),
      routes: {
        "/scanner": (context) => const ScannerPage(),
      },
      home: showSplash ? const SplashScreen() : const LoginState(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44),
              child: SvgPicture.asset(
                context.logoPath,
                width: double.infinity,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginState extends StatelessWidget {
  const LoginState({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) => snapshot.hasError ||
                snapshot.connectionState == ConnectionState.active &&
                    !snapshot.hasData
            ? const LoginPage()
            : const HomePage());
  }
}
