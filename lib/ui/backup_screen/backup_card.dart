// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:curly_create/io/art_data.dart';
import 'package:curly_create/io/backups.dart';
import 'package:curly_create/io/resource_manager.dart';
import 'package:curly_create/ui/art_view_screen/art_view.dart';
import 'package:curly_create/ui/backup_screen/backup_control_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BackupCard extends StatefulWidget {
  final ArtData artData;
  final bool backupActive;

  const BackupCard(
      {Key? key, required this.artData, required this.backupActive})
      : super(key: key);

  @override
  State<BackupCard> createState() => _BackupCardState();
}

class _BackupCardState extends State<BackupCard> {
  bool backupActive = false;
  bool backupDone = false;
  bool backupFailed = false;
  UploadTask? uploadTask;

  @override
  void initState() {
    super.initState();
    backupActive = widget.backupActive;
  }

  void startBackup() {
    uploadTask ??= imagesRef.child('${widget.artData.title}.jpeg').putFile(
        File(widget.artData.path),
        SettableMetadata(
            contentType: 'image/jpeg',
            customMetadata: <String, String>{
              "title": widget.artData.title,
              "description": widget.artData.description,
              "note": widget.artData.note,
              "colorTileIndex": '${widget.artData.colorTileIndex}'
            }));
    uploadTask?.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          backupActive = true;
          break;
        case TaskState.paused:
          backupActive = false;
          break;
        case TaskState.canceled:
          backupActive = false;
          break;
        case TaskState.error:
          backupFailed = true;
          backupActive = false;
          break;
        case TaskState.success:
          backupActive = false;
          backupDone = true;
          break;
      }
      rebuild();
    });
    rebuild();
  }

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => ArtView(artData: widget.artData),
              ));
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 2)
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 60,
                    height: 40,
                    child: FadeInImage(
                      placeholder: illustration,
                      image: FileImage(File(widget.artData.path)),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  widget.artData.title,
                  style: TextStyle(
                    fontFamily: "Itim",
                    color: Colors.grey.shade800,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FutureBuilder(
                        future: imagesRef
                            .child('${widget.artData.title}.jpeg')
                            .getDownloadURL(),
                        builder: (content, snapShot) {
                          if (snapShot.connectionState ==
                                  ConnectionState.waiting ||
                              backupActive) {
                            return const Icon(
                              Icons.timelapse_sharp,
                              color: Colors.blue,
                              size: 20,
                            );
                          } else if (backupFailed) {
                            return const Icon(
                              Icons.wifi_tethering_error_rounded_sharp,
                              color: Colors.redAccent,
                              size: 20,
                            );
                          } else if ((!snapShot.hasError &&
                                  snapShot.connectionState ==
                                      ConnectionState.done) ||
                              backupDone) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      tooltip:
                                          "Update Metadata (description and note)",
                                      onPressed: () async {
                                        showInSnackBar(context, "Updating Metadata of ${widget.artData.title} ... ");
                                        await imagesRef
                                            .child(
                                                '${widget.artData.title}.jpeg')
                                            .updateMetadata(SettableMetadata(
                                                contentType: 'image/jpeg',
                                                customMetadata: <String,
                                                    String>{
                                                  "title": widget.artData.title,
                                                  "description": widget
                                                      .artData.description,
                                                  "note": widget.artData.note,
                                                  "colorTileIndex":
                                                      '${widget.artData.colorTileIndex}'
                                                }));
                                        showInSnackBar(context, "Updated Metadata of ${widget.artData.title}.");
                                      },
                                      icon: const Icon(
                                        Icons.update,
                                        color: Colors.blueAccent,
                                      ),
                                      splashRadius: 25,
                                      iconSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.grey.shade700,
                                    size: 20,
                                  ),
                                ),
                              ],
                            );
                          }
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Material(
                              color: Colors.blueAccent.withOpacity(0.25),
                              child: IconButton(
                                onPressed: () {
                                  if (!backupDone &&
                                      !backupActive &&
                                      !backupFailed) {
                                    startBackup();
                                  }
                                },
                                tooltip: "Click to start backup",
                                icon: const Icon(
                                  Icons.play_arrow_outlined,
                                  color: Colors.blue,
                                ),
                                iconSize: 18,
                                splashRadius: 25,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
