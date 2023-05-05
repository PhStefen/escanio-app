import 'package:escanio_app/services/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final currentUser = FirebaseService.getUser();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(FirebaseService.getUser()!.isAnonymous);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 25),
      currentUser!.isAnonymous
          ? Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    'images/unnamed.png',
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
      )
    ]);
  }
}
