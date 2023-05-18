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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(FirebaseService.getUser()!.isAnonymous);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 250,
          child: Card(
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: currentUser!.isAnonymous
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'images/anonymous512.png',
                            height: 200,
                          ),
                        ),
                        const Text("Anônimo"),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ClipOval(
                            child: Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL
                              .toString(),
                          fit: BoxFit.cover,
                          height: 200,
                        )),
                        Text(
                          currentUser!.displayName!,
                          style: const TextStyle(
                            fontSize: 30,
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
                  ),
          ),
        ),
        SizedBox(
          width: 250,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  // side: BorderSide(color: Colors.white),
                ),
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors
                        .grey; // Define a cor do botão desabilitado como cinza
                  }
                  return Theme.of(context)
                      .colorScheme
                      .primary; // Define a cor do botão habilitado como verde
                },
              ),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: FirebaseService.signOut,
            child: SizedBox(
              height: 50,
              child: Stack(
                children: [
                  const Positioned(
                    left: 0,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Icon(Icons.login_rounded),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Fazer logout",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
