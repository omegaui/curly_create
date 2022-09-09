
import 'dart:io';

import 'package:curly_create/io/app_data_manager.dart';
import 'package:curly_create/io/art_data.dart';
import 'package:curly_create/io/authentication.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../io/backups.dart';

class DownloadCard extends StatefulWidget{

  final Reference reference;

  const DownloadCard({Key? key, required this.reference}) : super(key: key);

  @override
  State<DownloadCard> createState() => _DownloadCardState();
}

class _DownloadCardState extends State<DownloadCard> {

  bool downloadActive = false;
  bool downloadFailed = false;

  bool isArtPresentOffline(Map<String, String>? metadata){
    for(var artData in arts){
      if(artData.title == metadata?['title']) {
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

    final downloadTask = ref.writeToFile(file);
    downloadTask.snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          downloadActive = true;
          break;
        case TaskState.paused:
          downloadActive = false;
          break;
        case TaskState.success:
          arts.add(ArtData(metadata?['title'] as String, int.parse(metadata?['colorTileIndex'] as String), filePath, metadata?['description'] as String, metadata?['note'] as String));
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

  void showInSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'Itim', color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.all(20)));
  }

  void rebuild(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: widget.reference.getMetadata(),
            builder: (content, snapShot) {
              if(downloadFailed){
                return const Icon(
                  Icons.back_hand_outlined,
                  color: Colors.red,
                );
              }
              else if(snapShot.connectionState == ConnectionState.done) {
                FullMetadata metadata = snapShot.data as FullMetadata;
                bool downloaded = isArtPresentOffline(metadata.customMetadata);
                return Row(
                  children: [
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
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Icon(
                                Icons.timelapse_sharp,
                                color: Colors.blue,
                                size: 20,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: downloaded,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Icon(
                                Icons.done,
                                color: Colors.blue.shade700,
                                size: 20,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !downloaded && !downloadActive,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Material(
                                color: Colors.greenAccent.withOpacity(0.25),
                                child: IconButton(
                                  onPressed: () {
                                    startDownload(metadata.customMetadata);
                                  },
                                  tooltip: "Click to start download",
                                  icon: const Icon(
                                    Icons.file_download_rounded,
                                    color: Colors.green,
                                  ),
                                  splashRadius: 25,
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
              return Row(
                children: [
                  Text(
                    downloadActive ? "downloading data ..." : "pulling data ...",
                    style: TextStyle(
                      fontFamily: "Itim",
                      color: Colors.grey.shade800,
                    ),
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

