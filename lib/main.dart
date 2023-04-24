import 'package:escanio_app/view/home_page.dart';
import 'package:flutter/material.dart';
// import 'package:widget_toolkit/widget_toolkit.dart';
// import 'package:widget_toolkit_qr/widget_toolkit_qr.dart';

void main() {
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
      // theme: ThemeData.light().copyWith(
      //   colorScheme: ColorScheme.fromSwatch(),
      //   extensions: [
      //     WidgetToolkitTheme.light,
      //     QrScannerTheme.light,
      //   ],
      // ),
      // darkTheme: ThemeData.dark().copyWith(
      //   colorScheme: ColorScheme.fromSwatch(),
      //   extensions: [
      //     WidgetToolkitTheme.dark,
      //     QrScannerTheme.dark,
      //   ],
      // ),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
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
  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[const HomePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: _pages.elementAt(_selectedIndex),
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
