import 'package:curly_create/io/resource_manager.dart';
import 'package:curly_create/ui/backup_screen/backup_panel.dart';
import 'package:curly_create/ui/backup_screen/download_panel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../io/app_data_manager.dart';

final GlobalKey<BackupPanelState> backupPanelKey = GlobalKey();
final GlobalKey<DownloadPanelState> downloadPanelKey = GlobalKey();

class BackupView extends StatefulWidget {
  const BackupView({Key? key}) : super(key: key);

  @override
  State<BackupView> createState() => BackupViewState();
}

class BackupViewState extends State<BackupView> {
  int pageIndex = 0;

  void rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> setPageIndex(int index) async {
    setState(() {
      if (!guestMode) {
        pageIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  if (pageIndex == 0 && !guestMode)
                    const Image(
                      image: backup,
                      width: 48,
                      height: 48,
                    ),
                  if (pageIndex == 1 || guestMode)
                    Lottie.asset('assets/86198-satellite-signal.json',
                        width: 50),
                  const SizedBox(width: 20),
                  Text(
                    pageIndex == 0 && !guestMode
                        ? "Backups"
                        : "${loadedRemotes ? remoteArts!.items.length : ""} Arts",
                    style: TextStyle(
                      fontFamily: 'Itim',
                      fontSize: 24,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (!guestMode)
                          TextButton(
                            onPressed: () async {
                              if (pageIndex == 1) {
                                await loadAll();
                              }
                              await setPageIndex(pageIndex == 0 ? 1 : 0);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFFEFF0F3),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF0F3),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 30,
                                    offset: Offset(-20, -20),
                                  ),
                                  BoxShadow(
                                    color: Color(0xFFA3B1C6),
                                    blurRadius: 30,
                                    offset: Offset(20, 20),
                                  ),
                                ],
                              ),
                              child: Text(
                                pageIndex == 0
                                    ? "Download Backups"
                                    : "Create Backups",
                                style: TextStyle(
                                  fontFamily: "Itim",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (arts.isEmpty && pageIndex == 0 && !guestMode)
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Head Over to collections tab and",
                        style: TextStyle(
                          fontFamily: 'Itim',
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Text(
                        "Add your awesome arts to create backups",
                        style: TextStyle(
                          fontFamily: 'Itim',
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Text(
                        "or download from backups if already created one.",
                        style: TextStyle(
                          fontFamily: 'Itim',
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Lottie.asset(
                          'assets/70220-girl-is-capturing-pictures.json'),
                    ],
                  ),
                ),
              ),
            if (!guestMode)
              Visibility(
                  visible: arts.isNotEmpty && pageIndex == 0,
                  child: BackupPanel(key: backupPanelKey)),
            if (!guestMode)
              Visibility(
                  visible: pageIndex == 1,
                  child: DownloadPanel(key: downloadPanelKey)),
            if (guestMode) DownloadPanel(key: downloadPanelKey),
          ],
        ),
      ),
    );
  }
}
