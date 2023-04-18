import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 8)),
                Icon(Icons.menu, color: Colors.grey.shade600),
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
        Expanded(
          child: ListView(),
        )
      ],
    );
  }
}
