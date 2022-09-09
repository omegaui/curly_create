
import 'package:curly_create/main.dart';
import 'package:curly_create/ui/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../io/app_data_manager.dart';

class GiftView extends StatelessWidget{
  const GiftView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/86684-present-birthday.json'),
          Text(
            "Well, I wanna say",
            style: TextStyle(
              fontFamily: "Itim",
              color: Colors.grey.shade800,
            ),
          ),
          Text(
            "I take friendship seriously",
            style: TextStyle(
              fontFamily: "Itim",
              color: Colors.grey.shade800,
            ),
          ),
          Text(
            "and I just put all I hath",
            style: TextStyle(
              fontFamily: "Itim",
              color: Colors.grey.shade800,
            ),
          ),
          Text(
            "Hope, you'll like it",
            style: TextStyle(
              fontFamily: "Itim",
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              if(firstStartup){
                showInfoDialog(context);
                prefs?.setBool('first-startup', false);
              }
            },
            style: TextButton.styleFrom(
              primary: Colors.blueAccent,
            ),
            child: const Text(
              "let's see",
              style: TextStyle(
                fontFamily: "Itim",
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

}

