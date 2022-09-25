
import 'package:curly_create/ui/sign_in_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeView extends StatelessWidget{
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Happy",
              style: TextStyle(
                  fontFamily: "IrishGrover",
                  fontSize: 38,
              ),
            ),
            const Text(
              "Birthday",
              style: TextStyle(
                fontFamily: "IrishGrover",
                fontSize: 46,
              ),
            ),
            Lottie.asset('assets/37361-birthday-hat.json'),
            const Text(
              "from someone unworthy",
              style: TextStyle(
                fontFamily: "Itim",
              ),
            ),
            const SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.orangeAccent,
                  ),
                  child: Lottie.asset('assets/51922-cool.json', width: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

