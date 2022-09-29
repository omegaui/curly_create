import 'package:flutter/material.dart';

import '../../../io/resource_manager.dart';
import '../../../widgets/logo.dart';

class TopPanel extends StatelessWidget {
  const TopPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              blurRadius: 6,
              offset: Offset(0, -6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Row(
                children: const [
                  SizedBox(width: 15),
                  Image(
                    image: artViewIcon,
                    width: 48,
                    height: 48,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Art View",
                    style: TextStyle(
                      fontFamily: "Itim",
                      fontSize: 28,
                    ),
                  )
                ],
              ),
            ),
            Logo(),
          ],
        ),
      ),
    );
  }
}
