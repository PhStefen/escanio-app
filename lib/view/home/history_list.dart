import 'package:escanio_app/models/history.dart';
import 'package:escanio_app/view/home/history_item.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  var list = <History>[];
  HistoryList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...list.map((history) => HistoryItem(item: history))
      ],
    );
  }
}
