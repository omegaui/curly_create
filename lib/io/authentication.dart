import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../main.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();
FirebaseAuth _auth = FirebaseAuth.instance;

class Authentication {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user;

    try {
      await signOut(context: context);
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      String? email = userCredential.user?.email;
      if (email != null) {
        print(email);
        if (email == 'curlycreatebackups@gmail.com' ||
            email == 'arhamfar22@gmail.com') {
          user = userCredential.user;
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        showInSnackBar(
            context, 'The account already exists with a different credential.');
      } else if (e.code == 'invalid-credential') {
        showInSnackBar(
            context, 'Error occurred while accessing credentials. Try again.');
      }
    } catch (e) {
      showInSnackBar(
          context, 'Error occurred using Google Sign-In. Try again.');
    }

    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
      await _googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      // nothing to do
    }
  }
}

void showInSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(fontFamily: 'Itim', color: Colors.grey.shade800),
    ),
    backgroundColor: Colors.white,
    padding: const EdgeInsets.all(20),
    duration: const Duration(milliseconds: 700),
  ));
}
