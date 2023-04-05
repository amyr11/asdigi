import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';

import '../screens/home.dart';
import '../screens/login.dart';
import '../models/user.dart';

class AuthServices {
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          getCurrentUID().then((value) {
            CustomUser.addUserID(value);
          });
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }

  Future<FirebaseAuthException?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  Future<FirebaseAuthException?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      signInWithEmailAndPassword(email, password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<String> getCurrentUID() async {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  signOut() async {
    FirebaseAuth.instance.signOut();
    await GoogleSignIn().disconnect();
  }
}
