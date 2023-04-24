import 'package:escanio_app/view/home_page.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 8)),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Pesquise o nome ou código do produtos"),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                Icon(Icons.qr_code_rounded, color: Colors.grey.shade600),
                const Padding(padding: EdgeInsets.only(right: 8)),
              ],
            ),
          ),
        ),
      ),
      drawer: const SideBar(),
      body: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              menuHeader(context),
              menuItems(context),
            ],
          ),
        ),
      );

  Widget menuHeader(BuildContext context) => Container(
        color: Colors.red,
        padding: EdgeInsets.only(
          top: AppBar().preferredSize.height,
        ),
      );

  Widget menuItems(BuildContext context) => Wrap(
        runSpacing: 16, //Espaçamento na vertical
        children: [
          //Itens do Menu
          ListTile(
            leading: const Icon(Icons.home_rounded),
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Example'),
            onTap: () {},
          ),
          //Diviso bonitinho
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border_rounded),
            title: const Text('Favorite'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Example2'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Example3'),
            onTap: () {},
          ),
        ],
      );
}
