import 'package:curly_create/ui/backup_screen/backup_view.dart';
import 'package:curly_create/ui/backup_screen/download_panel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showBackupDeleteDialog(Reference ref, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
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
                      const Text(
                        "Do you really want to",
                        style: TextStyle(
                          fontFamily: 'Itim',
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                      const Text(
                        "delete this art?",
                        style: TextStyle(
                          fontFamily: 'Itim',
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Once Deleted it cannot be recovered!",
                        style: TextStyle(
                          fontFamily: 'Itim',
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Wrap(
                        spacing: 10,
                        children: [
                          TextButton(
                            onPressed: () async {
                              await ref.delete();
                              await loadAll();
                              Navigator.pop(context);
                              downloadPanelKey.currentState?.rebuild();
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                              backgroundColor:
                                  Colors.redAccent.withOpacity(0.2),
                            ),
                            child: const Text(
                              "Delete",
                              style: TextStyle(
                                fontFamily: 'Itim',
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                              backgroundColor:
                                  Colors.blueAccent.withOpacity(0.2),
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                fontFamily: 'Itim',
                                fontSize: 12,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Lottie.asset('assets/7502-delete.json', width: 60)),
            // Align(alignment: Alignment.center, child: Lottie.asset('assets/83730-winter-snow.json', height: 220, width: MediaQuery.of(context).size.width - 50)),
          ],
        ),
      ),
    ),
  );
}
