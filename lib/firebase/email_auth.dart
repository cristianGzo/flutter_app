import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class EmailAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> createUser(
      {required String emailUser, required String pwdUsr}) async {
    try {
      final crentials = await auth.createUserWithEmailAndPassword(
          email: emailUser, password: pwdUsr);
      //credentials.user!sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future validateUser(
      {required String emailUser, required String pwdUsr}) async {
    try {
      final credentials = await auth.signInWithEmailAndPassword(
          email: emailUser, password: pwdUsr);
      if (credentials.user!.emailVerified) {
        return true;
      } else {
        return false;
      }
    } catch (e) {}
  }
}
