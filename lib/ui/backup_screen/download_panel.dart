// ignore_for_file: unnecessary_null_comparison

import 'package:curly_create/io/backups.dart';
import 'package:curly_create/ui/backup_screen/backup_view.dart';
import 'package:curly_create/ui/backup_screen/download_card.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../main_screen/main_view.dart';

ListResult? remoteArts = null;

bool initDownloadView = true;

Future<void> loadAll() async {
  remoteArts = await imagesRef.list();
  initDownloadView = false;
  downloadPanelKey.currentState?.rebuild();
}

class DownloadPanel extends StatefulWidget {
  const DownloadPanel({Key? key}) : super(key: key);

  @override
  State<DownloadPanel> createState() => DownloadPanelState();
}

class DownloadPanelState extends State<DownloadPanel> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadAll();
    scrollController.addListener(() {
      if (scrollController.position.pixels == 0) {
        tabPanelKey.currentState?.setVisible(true);
      } else {
        tabPanelKey.currentState?.setVisible(false);
      }
    });
  }

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool empty = remoteArts == null ? true : remoteArts?.items.isEmpty as bool;
    return Expanded(
      child: Container(
        color: Colors.white,
        child: initDownloadView
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                      'assets/71003-big-data-centre-isomatric-animation-json.json'),
                  Text(
                    "connecting to server",
                    style: TextStyle(
                      fontFamily: "Itim",
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child:
                          Lottie.asset('assets/90530-owls.json', width: 200)),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Lottie.asset(
                          'assets/9844-loading-40-paperplane.json',
                          width: 250)),
                  SingleChildScrollView(
                    controller: scrollController,
                    child: remoteArts != null && !empty
                        ? Column(
                            children: remoteArts?.items
                                .map((e) => DownloadCard(reference: e))
                                .toList() as List<DownloadCard>,
                          )
                        : Column(
                            children: [
                              Text(
                                'No Backups Available to download',
                                style: TextStyle(
                                  fontFamily: 'Itim',
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              Lottie.asset(
                                  'assets/12955-no-internet-connection-empty-state.json'),
                            ],
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
