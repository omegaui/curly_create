import 'dart:io';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:curly_create/io/app_data_manager.dart';
import 'package:curly_create/io/art_data.dart';
import 'package:curly_create/ui/backup_delete_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../io/backups.dart';

class DownloadCard extends StatefulWidget {
  final Reference reference;

  const DownloadCard({Key? key, required this.reference}) : super(key: key);

  @override
  State<DownloadCard> createState() => _DownloadCardState();
}

class _DownloadCardState extends State<DownloadCard> {
  bool downloadActive = false;
  bool downloadFailed = false;

  bool isArtPresentOffline(Map<String, String>? metadata) {
    for (var artData in arts) {
      if (artData.title == metadata?['title']) {
        return true;
      }
    }
    return false;
  }

  void startDownload(Map<String, String>? metadata) async {
    final ref = imagesRef.child('${metadata?['title']}.jpeg');
    const appDocDir = '/storage/emulated/0/Download';
    final filePath = "$appDocDir/${metadata?['title']}.jpeg";
    final file = File(filePath);
    if (await file.exists()) {
      var data = ArtData(
          metadata?['title'] as String,
          int.parse(metadata?['colorTileIndex'] as String),
          filePath,
          metadata?['description'] as String,
          metadata?['note'] as String);
      arts.add(data);
      saveAppData();
      showInSnackBar(context, 'Added ${metadata?['title']}.');
      downloadActive = false;
      rebuild();
    } else {
      final downloadTask = ref.writeToFile(file);
      downloadTask.snapshotEvents.listen((taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            downloadActive = true;
            break;
          case TaskState.paused:
            downloadActive = false;
            break;
          case TaskState.success:
            var data = ArtData(
                metadata?['title'] as String,
                int.parse(metadata?['colorTileIndex'] as String),
                filePath,
                metadata?['description'] as String,
                metadata?['note'] as String);
            arts.add(data);
            saveAppData();
            showInSnackBar(context, 'Downloaded ${metadata?['title']}.');
            downloadActive = false;
            break;
          case TaskState.canceled:
            downloadActive = false;
            break;
          case TaskState.error:
            downloadActive = false;
            downloadFailed = true;
            break;
        }
        rebuild();
      });
    }
  }

  void showInSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Lottie.asset('assets/95088-success.json', width: 50),
          Text(
            message,
            style: TextStyle(fontFamily: 'Itim', color: Colors.grey.shade900),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(20),
      duration: const Duration(milliseconds: 800),
    ));
  }

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: widget.reference.getMetadata(),
            builder: (content, snapShot) {
              if (downloadFailed) {
                return const Icon(
                  Icons.back_hand_outlined,
                  color: Colors.red,
                );
              } else if (snapShot.connectionState == ConnectionState.done) {
                FullMetadata metadata = snapShot.data as FullMetadata;
                bool downloaded = isArtPresentOffline(metadata.customMetadata);
                return Row(
                  children: [
                    if (downloadActive)
                      Lottie.asset('assets/7572-download.json'),
                    if (downloadActive)
                      AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            "downloading ${(snapShot.data as FullMetadata).customMetadata?['title']}",
                            textStyle: const TextStyle(
                                fontFamily: 'Itim',
                                fontSize: 14,
                                color: Colors.blue),
                            colors: [
                              Colors.blue.shade700,
                              Colors.blue.shade300,
                              Colors.blue.shade900
                            ],
                          ),
                        ],
                        isRepeatingAnimation: true,
                      ),
                    if (!downloadActive)
                      Text(
                        metadata.customMetadata?['title'] as String,
                        style: TextStyle(
                          fontFamily: "Itim",
                          color: Colors.grey.shade800,
                        ),
                      ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: downloadActive,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Lottie.asset('assets/82387-download.json'),
                            ),
                          ),
                          Visibility(
                            visible: downloaded,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Icon(
                                Icons.done,
                                color: Colors.blue.shade700,
                                size: 20,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !guestMode && !downloadActive,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Material(
                                color: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    showBackupDeleteDialog(
                                        widget.reference, context);
                                  },
                                  tooltip: "Delete Backup Forever!",
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.redAccent,
                                  ),
                                  splashRadius: 16,
                                  iconSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !downloaded && !downloadActive,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Material(
                                color: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    startDownload(metadata.customMetadata);
                                  },
                                  tooltip: "Click to start download",
                                  icon: Icon(
                                    Icons.file_download_rounded,
                                    color: Colors.grey.shade700,
                                  ),
                                  splashRadius: 25,
                                  iconSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              //"downloading ${(snapShot.data as FullMetadata).customMetadata?['title']}"
              return Row(
                children: [
                  Lottie.asset('assets/7572-download.json'),
                  AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        downloadActive
                            ? "downloading ${(snapShot.data as FullMetadata).customMetadata?['title']}"
                            : "fetching metadata",
                        textStyle:
                            const TextStyle(fontFamily: 'Itim', fontSize: 14),
                        colors: downloadActive
                            ? [
                                Colors.blue.shade700,
                                Colors.blue.shade300,
                                Colors.blue.shade900
                              ]
                            : [
                                Colors.grey.shade700,
                                Colors.grey.shade300,
                                Colors.grey.shade900
                              ],
                      ),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
