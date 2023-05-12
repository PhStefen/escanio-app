import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/services/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final currentUser = FirebaseService.getUser();

  //Criar produtos
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // var productslist = [
  //   {
  //     'name': 'Banana',
  //     'prices': [
  //       {'date': '01/01/2023', 'value': 12},
  //       {'date': '01/02/2023', 'value': 14},
  //     ],
  //   },
  //   {
  //     'name': 'Maça',
  //     'prices': [
  //       {'date': '02/01/2023', 'value': 10},
  //       {'date': '02/02/2023', 'value': 12},
  //     ],
  //   },
  // ];
  var names = [
    'Arroz (1 kg)',
    'Feijão (1 kg)',
    'Açúcar (1 kg)',
    'Farinha de trigo (1 kg)',
    'Macarrão (500 g)',
    'Molho de tomate (340 g)',
    'Óleo de soja (900 ml)',
    'Sal refinado (1 kg)',
    'Café em pó (500 g)',
    'Leite longa vida (1 litro)',
    'Manteiga (200 g)',
    'Queijo mussarela (500 g)',
    'Presunto fatiado (100 g)',
    'Peito de frango (1 kg)',
    'Carne bovina (1 kg)',
    'Salsicha (500 g)',
    'Linguiça (500 g)',
    'Bacon (500 g)',
    'Batata (1 kg)',
    'Cenoura (1 kg)',
    'Tomate (1 kg)',
    'Cebola (1 kg)',
    'Alho (100 g)',
    'Repolho (1 unidade)',
    'Abobrinha (1 kg)',
    'Brócolis (1 maço)',
    'Banana (1 kg)',
    'Maçã (1 kg)',
    'Laranja (1 kg)',
    'Melancia (1 unidade)',
    'Uva (500 g)',
    'Morango (500 g)',
    'Abacaxi (1 unidade)',
    'Mamão (1 kg)',
    'Azeitona (200 g)',
    'Milho verde em conserva (200 g)',
    'Ervilha em conserva (200 g)',
    'Extrato de tomate (140 g)',
    'Milho de pipoca (500 g)',
    'Fermento em pó (100 g)',
    'Gelatina (85 g)',
    'Leite condensado (395 g)',
    'Creme de leite (200 g)',
    'Achocolatado em pó (400 g)',
    'Bolacha recheado (130 g)',
    'Bolacha salgado (200 g)',
    'Refrigerante (2 litros)',
    'Água mineral (500 ml)',
    'Cerveja (350 ml)',
  ];
  var prices = [
    [
      ['12/05/2023', 5.00],
      ['02/02/2023', 10.00],
      ['01/01/2023', 9.00],
    ],
    [
      ['12/05/2023', 8.00],
      ['02/03/2023', 10.00],
      ['10/02/2023', 12.00],
    ],
    [
      ['12/05/2023', 3.50],
      ['02/04/2023', 4.50],
      ['01/03/2023', 5.00],
    ],
    [
      ['12/05/2023', 3.00],
      ['02/02/2023', 2.50],
      ['01/01/2023', 4.00],
    ],
    [
      ['12/05/2023', 2.50],
      ['02/04/2023', 3.50],
      ['01/03/2023', 6.00],
    ],
    [
      ['12/05/2023', 2.00],
      ['02/04/2023', 5.50],
      ['01/03/2023', 4.50],
    ],
    [
      ['12/05/2023', 5.50],
      ['02/04/2023', 10.00],
      ['01/03/2023', 9.00],
    ],
    [
      ['12/05/2023', 2.00],
      ['15/04/2023', 2.50],
      ['15/03/2023', 3.50],
    ],
    [
      ['12/05/2023', 12.00],
      ['02/04/2023', 10.00],
      ['01/03/2023', 15.00],
    ],
    [
      ['12/05/2023', 3.50],
      ['02/04/2023', 8.00],
      ['01/03/2023', 5.00],
    ],
    [
      ['12/05/2023', 5.00],
      ['02/02/2023', 10.00],
      ['01/01/2023', 9.00],
    ],
    [
      ['12/05/2023', 15.00],
      ['02/02/2023', 22.00],
      ['01/01/2023', 19.50],
    ],
    [
      ['12/05/2023', 2.50],
      ['12/04/2023', 10.00],
      ['11/03/2023', 9.00],
    ],
    [
      ['12/05/2023', 10.00],
      ['13/04/2023', 10.00],
      ['13/03/2023', 9.00],
    ],
    [
      ['12/05/2023', 25.00],
      ['02/04/2023', 50.00],
      ['01/03/2023', 35.00],
    ],
    [
      ['12/05/2023', 6.00],
      ['02/04/2023', 9.90],
      ['01/03/2023', 8.00],
    ],
    [
      ['12/05/2023', 8.00],
      ['02/03/2023', 7.00],
      ['01/02/2023', 6.00],
    ],
    [
      ['12/05/2023', 15.00],
      ['02/03/2023', 25.00],
      ['01/02/2023', 12.90],
    ],
    [
      ['12/05/2023', 5.50],
      ['02/04/2023', 12.50],
      ['01/05/2023', 8.50],
    ],
    [
      ['12/05/2023', 4.00],
      ['02/04/2023', 10.00],
      ['01/03/2023', 9.00],
    ],
    [
      ['12/05/2023', 5.00],
      ['02/02/2023', 7.50],
      ['01/01/2023', 10.00],
    ],
    [
      ['12/05/2023', 3.00],
      ['02/04/2023', 3.50],
      ['01/03/2023', 5.00],
    ],
    [
      ['12/05/2023', 2.00],
      ['02/04/2023', 1.50],
      ['01/03/2023', 4.00],
    ],
    [
      ['12/05/2023', 3.50],
      ['02/02/2023', 5.50],
      ['01/01/2023', 7.00],
    ],
    [
      ['12/05/2023', 5.00],
      ['02/04/2023', 8.00],
      ['01/03/2023', 10.00],
    ],
    [
      ['12/05/2023', 4.00],
      ['02/04/2023', 5.00],
      ['01/03/2023', 6.00],
    ],
    [
      ['12/05/2023', 4.50],
      ['02/01/2023', 10.00],
      ['01/12/2022', 9.00],
    ],
    [
      ['12/05/2023', 6.00],
      ['02/03/2023', 18.00],
      ['01/02/2023', 10.00],
    ],
    [
      ['12/05/2023', 3.50],
      ['02/03/2023', 4.00],
      ['01/02/2023', 6.00],
    ],
    [
      ['12/05/2023', 9.00],
      ['02/04/2023', 10.00],
      ['01/03/2022', 13.50],
    ],
    [
      ['12/05/2023', 8.00],
      ['02/03/2023', 11.00],
      ['01/02/2023', 9.00],
    ],
    [
      ['12/05/2023', 12.00],
      ['02/04/2023', 16.00],
      ['01/03/2023', 14.00],
    ],
    [
      ['12/05/2023', 5.00],
      ['02/02/2023', 10.00],
      ['01/01/2023', 9.00],
    ],
    [
      ['12/05/2023', 4.00],
      ['02/02/2023', 4.50],
      ['01/01/2023', 9.00],
    ],
    [
      ['12/05/2023', 7.50],
      ['02/04/2023', 7.00],
      ['01/03/2023', 6.00],
    ],
    [
      ['12/05/2023', 2.50],
      ['01/04/2023', 3.00],
      ['01/03/2023', 4.00],
    ],
    [
      ['12/05/2023', 3.00],
      ['02/04/2023', 3.50],
      ['01/03/2023', 2.00],
    ],
    [
      ['12/05/2023', 2.50],
      ['02/03/2023', 1.00],
      ['01/02/2023', 2.00],
    ],
    [
      ['12/05/2023', 4.00],
      ['02/03/2023', 6.00],
      ['01/02/2023', 7.00],
    ],
    [
      ['12/05/2023', 2.00],
      ['02/03/2023', 1.50],
      ['01/02/2023', 4.00],
    ],
    [
      ['12/05/2023', 1.99],
      ['02/04/2023', 2.50],
      ['01/03/2023', 3.00],
    ],
    [
      ['12/05/2023', 4.50],
      ['02/03/2023', 10.00],
      ['01/02/2023', 9.00],
    ],
    [
      ['12/05/2023', 4.00],
      ['02/04/2023', 5.00],
      ['01/03/2023', 9.00],
    ],
    [
      ['12/05/2023', 6.00],
      ['02/02/2023', 6.50],
      ['01/01/2023', 9.00],
    ],
    [
      ['12/05/2023', 2.50],
      ['01/03/2023', 4.00],
      ['01/02/2023', 5.00],
    ],
    [
      ['12/05/2023', 5.00],
      ['02/01/2023', 5.00],
      ['01/12/2022', 6.00],
    ],
    [
      ['12/05/2023', 7.00],
      ['04/01/2023', 10.00],
      ['01/12/2023', 9.00],
    ],
    [
      ['12/05/2023', 1.50],
      ['04/01/2023', 4.00],
      ['09/12/2022', 3.00],
    ],
    [
      ['12/05/2023', 3.50],
      ['02/01/2023', 7.50],
      ['01/12/2023', 8.00],
    ],
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(FirebaseService.getUser()!.isAnonymous);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        currentUser!.isAnonymous
            ? Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'images/anonymous512.png',
                      height: 300,
                    ),
                  ),
                  const Text(
                    "Anônimo",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  ClipOval(
                      child: Image.network(
                    FirebaseAuth.instance.currentUser!.photoURL.toString(),
                    fit: BoxFit.cover,
                    height: 300,
                  )),
                  Text(
                    currentUser!.displayName!,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text(
                  //   "Email: ${FirebaseAuth.instance.currentUser!.email.toString()}",
                  //   style: const TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
        const Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: FirebaseService.signOut,
              child: Text(
                "Sair",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        //NÃO TOCAR
        // ElevatedButton(
        //   onPressed: () async {
        //     // for (var product in productslist) {
        //     //   final CollectionReference productsRef =
        //     //       FirebaseFirestore.instance.collection('products');
        //     //   final DocumentReference newProductRef =
        //     //       await productsRef.add({'name': product['name']});
        //     //   final CollectionReference pricesRef =
        //     //       newProductRef.collection('prices');
        //     //   for (var price in product['prices']) {
        //     //     await pricesRef
        //     //         .add({'value': price['value'], 'date': price['date']});
        //     //   }
        //     // }
        //     for (var i = 0; i < names.length; i++) {
        //       final CollectionReference productsRef =
        //           FirebaseFirestore.instance.collection('products');
        //       final DocumentReference newProductRef =
        //           await productsRef.add({'name': names[i]});
        //       final CollectionReference pricesRef =
        //           newProductRef.collection('prices');
        //       for (var o in prices[i]) {
        //         String dateString = o[0].toString();
        //         DateTime date = DateFormat('dd/MM/yyyy').parse(dateString);
        //         await pricesRef.add({'date': date, 'value': o[1]});
        //       }
        //     }
        //   },
        //   child: Text("Criar Produtos"),
        // ),
      ],
    );
  }
}
