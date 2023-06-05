import 'package:escanio_app/services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static Future init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
