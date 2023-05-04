import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCard extends StatefulWidget {
  QueryDocumentSnapshot<Map<String, dynamic>> produto;
  MyCard({super.key, required this.produto});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool favorito = false;

  @override
  initState() {
    super.initState();
    favorito = !!widget.produto["favorito"];
  }

  toggleFavorite() {
    setState(() {
      favorito = !favorito;
    });
  }

  showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () => {},
            ),
            content: WillPopScope(
              onWillPop: () async {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                return true;
              },
              child: Text(favorito
                  ? "Removido dos favoritos"
                  : "Adicionado aos favoritos"),
            ),
          ),
        )
        .closed
        .then(
          (reason) => reason == SnackBarClosedReason.action
              ? toggleFavorite()
              : widget.produto.reference.update({
                  'favorito': favorito,
                }),
        );
    toggleFavorite();
  }

  @override
  Widget build(BuildContext context) => Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding( 
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                direction: Axis.vertical,
                children: [
                  Text(
                    widget.produto['nome'].toString().replaceFirstMapped(
                          RegExp(r'.'),
                          (match) => match.group(0)!.toUpperCase(),
                        ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'pt_BR',
                      decimalDigits: 2,
                      symbol: 'R\$',
                    ).format(widget.produto['preco']),
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  const Text(
                    "10/10/2023",
                    style: TextStyle(fontSize: 12),
                  ),
                  GestureDetector(
                    onTap: () => showSnackBar(context),
                    child: Icon(
                      favorito ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}