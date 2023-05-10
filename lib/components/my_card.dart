import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCard extends StatefulWidget {
  MyCard({super.key});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  initState() {
    super.initState();
  }

  showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: Text('Teste'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () => showModal,
        child: const Text("Show modal"),
      );
}
