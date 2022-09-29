import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final bool active;
  final IconData iconData;
  final String title;
  final VoidCallback callback;

  const TabButton(
      {Key? key,
      required this.active,
      required this.iconData,
      required this.title,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callback,
      style: TextButton.styleFrom(
        primary: active ? Colors.blueAccent : Colors.grey.shade500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: SizedBox(
        width: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: active ? Colors.blueAccent : Colors.grey.shade900,
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: "Itim",
                color: active ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
