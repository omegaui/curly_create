import 'package:curly_create/io/app_data_manager.dart';
import 'package:curly_create/io/resource_manager.dart';
import 'package:curly_create/ui/welcome_screen/start_screen.dart';
import 'package:curly_create/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.grey.withOpacity(0.3),
      child: SizedBox(
        height: 300,
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Container(
                  width: 270,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: const Image(
                          image: profileImage,
                          width: 48,
                          height: 48,
                        ),
                      ),
                      Logo(scale: 0.5),
                      Text(
                        "v$version-stable",
                        style: TextStyle(
                          fontFamily: "Itim",
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      const LottieController(
                          name: "72700-cute-bunnies-love-animation.json",
                          duration: Duration(milliseconds: 1200),
                          delay: Duration(milliseconds: 1000),
                          size: 40),
                      const SizedBox(height: 10),
                      Lottie.asset('assets/76879-waves-colors.json', width: 50),
                    ],
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Lottie.asset('assets/33321-cute-owl.json', width: 60)),
            Align(
                alignment: Alignment.center,
                child: Lottie.asset('assets/83730-winter-snow.json',
                    height: 220,
                    width: MediaQuery.of(context).size.width - 50)),
          ],
        ),
      ),
    ),
  );
}
