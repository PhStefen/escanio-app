import 'package:escanio_app/pages/home_page.dart';
import 'package:escanio_app/pages/login_page.dart';
import 'package:escanio_app/pages/scanner_page.dart';
import 'package:escanio_app/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool showSplash = true;

  @override
  void initState() {
    super.initState();
    FirebaseService.init().then((value) {
      setState(() {
        showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Escânio",
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
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
    return Container();
    // return Container(
    //   decoration: const BoxDecoration(
    //     image: DecorationImage(
    //       image: AssetImage("images/LogoScanner.png"),
    //     ),
    //   ),
    // );
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
