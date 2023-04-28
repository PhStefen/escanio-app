import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(FirebaseAuth.instance.currentUser!.displayName.toString()),
      Image.network(FirebaseAuth.instance.currentUser!.photoURL.toString()),
      ElevatedButton(
        onPressed: () async {
          Future.wait([
            FirebaseAuth.instance.signOut(),
            GoogleSignIn().signOut(),
          ]);
        },
        child: Text("Sair"),
      )
    ]);
  }
}
