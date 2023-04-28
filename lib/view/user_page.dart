import 'dart:developer';

import 'package:escanio_app/services/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final currentUser = FirebaseService.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(currentUser!.isAnonymous ? "Anônimo" : currentUser!.displayName!),
      if (!currentUser!.isAnonymous)
        Image.network(FirebaseAuth.instance.currentUser!.photoURL.toString()),
      const ElevatedButton(
        onPressed: FirebaseService.signOut,
        child: Text("Sair"),
      )
    ]);
  }
}
