import 'dart:io';

import 'package:escanio_app/services/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: loading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    'images/LogoScaner.png',
                    height: 300,
                  ),

                  //Botão do anônimo com o texto
                  SizedBox(
                    width: 300,
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
                              return Colors.grey; // Define a cor do botão desabilitado como cinza
                            }
                            return Theme.of(context).colorScheme.primary; // Define a cor do botão habilitado como verde
                          },
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      // onPressed: null,
                      onPressed: /*loading ? null : */ () {
                        setState(() {
                          loading = true;
                        });
                        FirebaseService.signInAnonymously();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'images/anonymous32.png',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text("Logar como Anônimo"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  //Botão do google com o texto
                  if (!kIsWeb)
                    SizedBox(
                      width: 300,
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
                                return Colors.grey; // Define a cor do botão desabilitado como cinza
                              }
                              return Theme.of(context).colorScheme.primary; // Define a cor do botão habilitado como verde
                            },
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: /*loading ? null : */ () {
                          setState(() {
                            loading = true;
                          });
                          FirebaseService.signInGoogle();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
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
                            ),
                            const SizedBox(width: 20),
                            const Text('Logar com o Google'),
                          ],
                        ),
                      ),
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
