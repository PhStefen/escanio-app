import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.qr_code_rounded,
              size: 300,
            ),
            ElevatedButton(
              onPressed: () async {
                var googleUser = await GoogleSignIn().signIn();
                var googleAuth = await googleUser?.authentication;
                var credential = GoogleAuthProvider.credential(
                  accessToken: googleAuth?.accessToken,
                  idToken: googleAuth?.idToken,
                );
                var user = await FirebaseAuth.instance
                    .signInWithCredential(credential);
              },
              child: const Text("Continuar com o Google"),
            )
          ],
        ),
      ),
    );
  }
}
