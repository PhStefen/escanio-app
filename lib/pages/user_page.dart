import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/history_model.dart';
import 'package:escanio_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  final List<HistoryModel> history;
  final void Function() onBack;
  const UserPage({super.key, required this.history, required this.onBack});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final currentUser = AuthService.user;

  //Criar produtos
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Container(
                  color: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsetsDirectional.only(start: 10, top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: widget.onBack,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primary,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(top: 54),
                      child: Text(
                        currentUser!.isAnonymous
                            ? 'Anônimo'
                            : FirebaseAuth.instance.currentUser!.displayName
                                .toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
            //Imagem de Perfil
            Positioned(
              bottom: 0,
              child: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(132 / 2),
                    color: Colors.white,
                  ),
                  height: 132,
                  width: 132,
                  padding: currentUser!.isAnonymous
                      ? const EdgeInsets.all(16)
                      : null,
                  child: currentUser!.isAnonymous
                      ? Image.asset(
                          'images/anonymous512.png',
                          height: 132,
                          width: 132,
                        )
                      : Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL
                              .toString(),
                          fit: BoxFit.cover,
                          height: 132,
                          width: 132,
                        ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Botão Favorito
              GestureDetector(
                onTap: widget.onBack,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          child: Row(
                            children: [
                              Text(
                                widget.history
                                    .where((h) => h.isFavourite)
                                    .length
                                    .toString(),
                              ),
                              const SizedBox(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.favorite_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(width: 20),
                                Text(
                                  "Favoritos",
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

              const SizedBox(height: 12),

              //Botão Histórico
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        child: Row(
                          children: [
                            Text(widget.history.length.toString()),
                            const SizedBox(
                              height: 50,
                              width: 50,
                              child: Icon(Icons.history, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              SizedBox(width: 20),
                              Text(
                                "Histórico",
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

              //Botão Sair
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              // side: BorderSide(color: Colors.white),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).cardColor ==
                                      const Color(0xffffffff)
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).cardColor),
                        ),
                        onPressed: AuthService.signOut,
                        child: SizedBox(
                          height: 50,
                          child: Stack(
                            children: [
                              const Positioned(
                                right: 0,
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    Icons.login_rounded,
                                    color: Colors.white,
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
                                        "Sair",
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
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
