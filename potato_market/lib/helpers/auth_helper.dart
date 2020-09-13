import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  static Future<void> createUser(email, password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signIn(email, password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
