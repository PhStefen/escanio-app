import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  static final _instance = FirebaseAuth.instance;
  static const _firebaseOptions = FirebaseOptions(
    apiKey: "AIzaSyDeQ-h2ArRXoGBKEPvverssaCP6MLP8RPA",
    authDomain: "escanio-app-17dca.firebaseapp.com",
    projectId: "escanio-app-17dca",
    storageBucket: "escanio-app-17dca.appspot.com",
    messagingSenderId: "384208942515",
    appId: "1:384208942515:web:cffba28106c4fb37b5c7c6",
    measurementId: "G-9S0KHNCVH2",
  );
  static final currentUser = FirebaseAuth.instance.currentUser;

  static Future init() async {
    await Firebase.initializeApp(
      options: kIsWeb ? _firebaseOptions : null,
    );
  }

  static Future signIn() async {
    if (kIsWeb) {
      await _instance.signInAnonymously();
      return;
    }

    var googleUser = await GoogleSignIn().signIn();
    var googleAuth = await googleUser?.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await _instance.signInWithCredential(credential);
  }

  static Future signOut() async {
    var futures = [_instance.signOut()];
    if (!currentUser!.isAnonymous) {
      futures.add(GoogleSignIn().signOut());
    }
    await Future.wait(futures);
  }
}
