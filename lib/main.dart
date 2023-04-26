import 'package:escanio_app/view/favorites_page.dart';
import 'package:escanio_app/view/scanner_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:escanio_app/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:widget_toolkit/widget_toolkit.dart';
import 'package:widget_toolkit_qr/widget_toolkit_qr.dart';

const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyDeQ-h2ArRXoGBKEPvverssaCP6MLP8RPA",
  authDomain: "escanio-app-17dca.firebaseapp.com",
  projectId: "escanio-app-17dca",
  storageBucket: "escanio-app-17dca.appspot.com",
  messagingSenderId: "384208942515",
  appId: "1:384208942515:web:cffba28106c4fb37b5c7c6",
  measurementId: "G-9S0KHNCVH2",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Escânio',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
        extensions: [
          WidgetToolkitTheme.light,
          QrScannerTheme.light,
        ],
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
        extensions: [
          WidgetToolkitTheme.dark,
          QrScannerTheme.dark,
        ],
      ),
      routes: {
        "/scanner": (context) => const ScannerPage(),
      },
      initialRoute: "/",
      home: const App(),
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

  void _onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const FavoritesPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red.shade900,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_rounded),
            label: "Favoritos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
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
