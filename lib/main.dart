import 'dart:ui';

import 'package:escanio_app/models/history.dart';
import 'package:escanio_app/services/firebase_service.dart';
import 'package:escanio_app/services/history_service.dart';
import 'package:escanio_app/view/favorites_page.dart';
import 'package:escanio_app/view/login_page.dart';
import 'package:escanio_app/view/scanner_page.dart';
import 'package:escanio_app/view/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:escanio_app/view/history_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showSplash = true;

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();
    FirebaseService.init().then((value) => setState(() {
          showSplash = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Escânio',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
      ),
      routes: {
        "/scanner": (context) => const ScannerPage(),
        "/login": (context) => const LoginPage(),
      },
      initialRoute: "/",
      home: showSplash
          ? Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/LogoScaner.png'),
                ),
              ),
            )
          : StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return (snapshot.hasError ||
                        snapshot.connectionState == ConnectionState.active &&
                            !snapshot.hasData)
                    ? const LoginPage()
                    : const App();
              },
            ),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  final _pageController = PageController(initialPage: 0);
  final history = <History>[];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(microseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: HistoryService.getAll(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              print(snapshot.data!.docs);
              history.clear();
              history.addAll(snapshot.data!.docs.map((e) => e.data()));
              return PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  HistoryPage(history: history),
                  FavoritesPage(
                    favourites: history
                        .where((element) => element.isFavourite)
                        .toList(),
                  ),
                  const UserPage(),
                ],
              );
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 0 ? Icons.home_rounded : Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 1 ? Icons.favorite : Icons.favorite_border),
            label: "Favoritos",
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 2
                ? Icons.person_rounded
                : Icons.person_outline_rounded),
            label: "Conta",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onTap,
      ),
    );
  }
}

class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
      };
}
