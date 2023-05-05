import 'dart:io';

import 'package:escanio_app/services/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/LogoScaner.png',
              height: 300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'images/unnamed.png',
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: FirebaseService.signInAnonymously,
                      ),
                    ),
                    const Text('Continuar como Anônimo'),
                  ],
                ),
                if (!kIsWeb)
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'images/google_PNG19635.png',
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: FirebaseService.signInGoogle,
                      ),
                    ),
                    const Text('Continuar com o Google'),
                  ],
                ),
              ],
            ),
            // const ElevatedButton(
            //   onPressed: FirebaseService.signIn,
            //   child: Text("Continuar com o Google"),
            // ),
          ],
        ),
      ),
    );
  }
}
