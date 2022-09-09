import 'package:curly_create/io/authentication.dart';
import 'package:curly_create/ui/sign_in_screen/google_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  SignInScreenState createState() => SignInScreenState();
}
class SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/23317-payment-declined-authentication-app-animation.json'),
                    Text(
                      'let\'s secure your arts ~ forever',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontFamily: "Itim",
                      ),
                    ),
                    Text(
                      'Authentication is required to create backups',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontFamily: "Itim",
                      ),
                    ),
                  ],
                ),
              ),
              const GoogleSignInButton(),
            ],
          ),
        ),
      ),
    );
  }
}