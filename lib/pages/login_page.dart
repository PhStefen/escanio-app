import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/components/loading.dart';
import 'package:escanio_app/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    await (googleSignIn ? AuthService.signInGoogle() : AuthService.signInAnonymously());

    FirebaseFirestore.instance.collection("users").doc(AuthService.user!.uid).set({});
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
                        SvgPicture.asset(
                          "images/logo_escuro.svg",
                          height: 300,
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                    Column(
                      children: [
                        //Novo Botão Login anônimo
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  // side: BorderSide(color: Colors.white),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor == const Color(0xffffffff)
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).cardColor),
                            ),
                            onPressed: () => signIn(false),
                            child: SizedBox(
                              height: 50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    right: 0,
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: const [
                                          SizedBox(width: 5),
                                          Text(
                                            "Continuar como anônimo",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
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

                        //Novo Botão Login google
                        if (!kIsWeb)
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    // side: BorderSide(color: Colors.white),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor == const Color(0xffffffff)
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).cardColor),
                              ),
                              onPressed: () => signIn(true),
                              child: SizedBox(
                                height: 50,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      right: 0,
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: const [
                                            SizedBox(width: 5),
                                            Text(
                                              "Continuar como Google",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
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
                  ],
                ),
        ),
      ),
    );
  }
}
