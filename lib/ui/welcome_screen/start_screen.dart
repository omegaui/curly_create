
import 'package:curly_create/ui/welcome_screen/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StartScreen extends StatelessWidget{
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/34452-hi-button-animation.json', width: 200),
            const Text(
              "Everyone is lonely sometimes",
              style: TextStyle(
                fontFamily: "Itim",
              ),
            ),
            const Text(
              "But I would walk a thousand miles",
              style: TextStyle(
                fontFamily: "Itim",
              ),
            ),
            const Text(
              "To see you rise",
              style: TextStyle(
                fontFamily: "Itim",
              ),
            ),
            Lottie.asset('assets/116190-dancing-star.json', width: 150),
            const Text(
              "Remember, Be happy always",
              style: TextStyle(
                fontFamily: "Itim",
              ),
            ),
            const Text(
              "either with me or without me",
              style: TextStyle(
                fontFamily: "Itim",
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const WelcomeView(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.blueAccent,
                  ),
                  child: Icon(
                    Icons.navigate_next,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
