import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/components/loading.dart';
import 'package:escanio_app/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;

  Future signIn(bool googleSignIn) async {
    setState(() {
      loading = true;
    });
    await (googleSignIn
        ? AuthService.signInGoogle()
        : AuthService.signInAnonymously());
        
    FirebaseFirestore.instance
        .collection("users")
        .doc(AuthService.user!.uid)
        .set({});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: loading
              ? const Loading()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'images/LogoScanner.png',
                          height: 300,
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                    Column(
                      children: [
                        //Botão do anônimo com o texto
                        SizedBox(
                          width: 364,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  // side: BorderSide(color: Colors.white),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
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
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () => signIn(false),
                            child: SizedBox(
                              height: 50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    child: Container(
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
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "Continuar como anônimo",
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

                        const SizedBox(height: 20),

                        //Botão do google com o texto
                        if (!kIsWeb)
                          SizedBox(
                            width: 364,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors
                                          .grey; // Define a cor do botão desabilitado como cinza
                                    }
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary; // Define a cor do botão habilitado como verde
                                  },
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              // onPressed: null,
                              onPressed: () => signIn(true),
                              child: SizedBox(
                                height: 50,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      child: Container(
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
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "Continuar como Google",
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
                    ),

                    // const ElevatedButton(
                    //   onPressed: FirebaseService.signIn,
                    //   child: Text("Continuar com o Google"),
                    // ),
                  ],
                ),
        ),
      ),
    );
  }
}


