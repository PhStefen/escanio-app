import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static User? get user => FirebaseAuth.instance.currentUser;
  static FirebaseAuth get _auth => FirebaseAuth.instance;

  static Future signInGoogle() async {
    var googleUser = await GoogleSignIn().signIn();
    var googleAuth = await googleUser?.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await _auth.signInWithCredential(credential);
  }

  static Future signInAnonymously() async {
    await _auth.signInAnonymously();
  }

  static Future signOut() async {
    var futures = [_auth.signOut()];
    if (!user!.isAnonymous) {
      futures.add(GoogleSignIn().signOut());
    }
    await Future.wait(futures);
  }
}
