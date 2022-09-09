// ignore_for_file: use_build_context_synchronously

import 'package:curly_create/io/app_data_manager.dart';
import 'package:curly_create/ui/welcome_screen/gift_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../io/authentication.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  GoogleSignInButtonState createState() => GoogleSignInButtonState();
}

class GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? Lottie.asset('assets/79157-login.json')
          : OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () async {
          setState(() {
            _isSigningIn = true;
          });

          User? user = await Authentication.signInWithGoogle(context: context);

          setState(() {
            _isSigningIn = false;
          });

          if (user != null) {
            await prefs?.setBool('logged-in', true);
            loggedIn = true;
            showSuccessfulLoginSnackBar(context, 'Ready to create backups!');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Scaffold(body: GiftView()),
              ),
            );
          }
          else{
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.redAccent,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset('assets/106983-failed.json', width: 200, height: 200),
                            const Text(
                              "Try Again",
                              style: TextStyle(
                                fontFamily: 'Itim',
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontFamily: "Itim",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//95088-success.json
void showSuccessfulLoginSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Lottie.asset('assets/95088-success.json', width: 50),
          Text(
            message,
            style: TextStyle(fontFamily: 'Itim', color: Colors.grey.shade800),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(20)));
}
