
import 'package:curly_create/io/resource_manager.dart';
import 'package:curly_create/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showInfoDialog(BuildContext context){
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 200,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              blurRadius: 4,
              spreadRadius: 4,
            ),
          ],
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
            const Text(
              "v1.0-stable",
              style: TextStyle(
                fontFamily: "Itim",
                color: Colors.grey,
              ),
            ),
            Lottie.asset('assets/72700-cute-bunnies-love-animation.json', width: 40),
            Text(
              "everytime I do something that hurts you",
              style: TextStyle(
                fontFamily: "Itim",
                fontSize: 12,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
            Text(
              "please forgive me -- I know I'm mad",
              style: TextStyle(
                fontFamily: "Itim",
                fontSize: 12,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
            Text(
              "but I only love, to torture you",
              style: TextStyle(
                fontFamily: "Itim",
                fontSize: 12,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

