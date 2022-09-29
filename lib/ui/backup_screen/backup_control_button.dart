import 'package:flutter/material.dart';

class BackupControlButton extends StatelessWidget {
  final bool backupRunning;
  final bool backupCompleted;
  final String percentage;
  final VoidCallback onPressed;

  const BackupControlButton(
      {Key? key,
      required this.backupRunning,
      required this.backupCompleted,
      required this.onPressed,
      required this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (backupCompleted) {
      return Icon(
        Icons.done,
        color: Colors.grey.shade700,
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          color: backupRunning
              ? Colors.blue.withOpacity(0.25)
              : Colors.green.withOpacity(0.25),
          child: IconButton(
            onPressed: onPressed,
            tooltip: "Click to toggle upload",
            icon: backupRunning
                ? Text(
                    percentage,
                    style: const TextStyle(
                      fontFamily: "Itim",
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  )
                : const Icon(
                    Icons.play_arrow_outlined,
                    color: Colors.green,
                  ),
            splashRadius: 25,
          ),
        ),
      );
    }
  }
}
