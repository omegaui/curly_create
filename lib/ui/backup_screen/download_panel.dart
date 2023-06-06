// ignore_for_file: unnecessary_null_comparison

import 'package:curly_create/io/art_data.dart';
import 'package:curly_create/io/backups.dart';
import 'package:curly_create/ui/backup_screen/backup_view.dart';
import 'package:curly_create/ui/backup_screen/download_card.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../main_screen/main_view.dart';

ListResult? remoteArts;
List<String> remoteArtNames = [];

bool initDownloadView = true;

Future<void> loadAll() async {
  remoteArtNames.clear();
  remoteArts = await imagesRef.list();
  bool empty = remoteArts == null ? true : remoteArts?.items.isEmpty as bool;
  if (!empty) {
    for (var ref in (remoteArts?.items as List<Reference>)) {
      FullMetadata metadata = await ref.getMetadata();
      remoteArtNames.add(metadata.customMetadata?['title'] as String);
    }
  }
  initDownloadView = false;
  downloadPanelKey.currentState?.rebuild();
  mainPanelKey.currentState?.rebuild();
}

bool isPresentOnRemoteServer(ArtData artData) {
  bool empty = remoteArts == null ? true : remoteArts?.items.isEmpty as bool;
  if (!empty) {
    return remoteArtNames.contains(artData.title);
  }
  return false;
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

  Alignment getOwlAlignment() {
    bool empty = remoteArts == null ? true : remoteArts?.items.isEmpty as bool;
    if (!empty) {
      var size = remoteArts?.items.length as int;
      if (size <= 8) {
        return Alignment.bottomRight;
      }
    }
    return Alignment.centerRight;
  }

  Alignment getPlaneAlignment() {
    bool empty = remoteArts == null ? true : remoteArts?.items.isEmpty as bool;
    if (!empty) {
      var size = remoteArts?.items.length as int;
      if (size > 6) {
        return Alignment.bottomLeft;
      }
    }
    return Alignment.centerLeft;
  }

  EdgeInsets getOwlPadding() {
    if (getOwlAlignment() == Alignment.bottomRight) {
      return const EdgeInsets.only(bottom: 70);
    }
    return EdgeInsets.zero;
  }

  EdgeInsets getPlanePadding() {
    if (getPlaneAlignment() == Alignment.bottomLeft) {
      return const EdgeInsets.only(bottom: 30);
    }
    return EdgeInsets.zero;
  }

  bool getAnimationVisible() {
    bool empty = remoteArts == null ? true : remoteArts?.items.isEmpty as bool;
    if (!empty) {
      var size = remoteArts?.items.length as int;
      if (size > 8) {
        return false;
      }
    }
    return true;
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
                  if (getAnimationVisible())
                    Align(
                        alignment: getOwlAlignment(),
                        child: Padding(
                            padding: getOwlPadding(),
                            child: Lottie.asset('assets/90530-owls.json',
                                width: 200))),
                  if (getAnimationVisible())
                    Align(
                        alignment: getPlaneAlignment(),
                        child: Padding(
                          padding: getPlanePadding(),
                          child: Lottie.asset(
                              'assets/9844-loading-40-paperplane.json',
                              width: 250),
                        )),
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
