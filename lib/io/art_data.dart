import 'dart:io';

import 'package:curly_create/io/resource_manager.dart';
import 'package:curly_create/ui/art_edit_screen/art_edit.dart';
import 'package:curly_create/ui/art_edit_screen/tile_wave_picker.dart';
import 'package:curly_create/ui/art_view_screen/art_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../ui/main_screen/main_view.dart';
import 'app_data_manager.dart';

class ArtData {
  String title;
  int colorTileIndex;
  final String path;
  String description;
  String note;
  late FileImage image;

  bool _editButtonPressed = false;
  bool _viewButtonPressed = false;
  bool _shareButtonPressed = false;
  bool _deleteButtonPressed = false;

  ArtData(
      this.title, this.colorTileIndex, this.path, this.description, this.note) {
    image = FileImage(File(path));
  }

  ImageProvider getTileWaveData() {
    return getTileWave(colorTileIndex);
  }

  @override
  String toString() {
    return "{\"title\": \"$title\", \"colorTileIndex\": $colorTileIndex, \"path\": \"$path\", \"description\": \"$description\", \"note\": \"$note\"}";
  }

  void showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Container(
            color: Colors.transparent,
            height: 150,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    ),
                    child: Center(
                      child: Wrap(
                        spacing: 20,
                        children: [
                          StatefulBuilder(
                              builder: (context, setState) {
                                return NeumorphicButton(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ArtView(artData: this)));
                                    setState(() {
                                      _viewButtonPressed = true;
                                    });
                                    Future.delayed(const Duration(milliseconds: 500),
                                          () {
                                        setState(() {
                                          _viewButtonPressed = false;
                                        });
                                      },
                                    );
                                  },
                                  pressed: _viewButtonPressed,
                                  child: const Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.blue,
                                    size: 24,
                                  ),
                                );
                              }
                          ),
                          StatefulBuilder(
                              builder: (context, setState) {
                                return NeumorphicButton(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ArtEditView(artData: this)));
                                    setState(() {
                                      _editButtonPressed = true;
                                    });
                                    Future.delayed(const Duration(milliseconds: 500),
                                          () {
                                        setState(() {
                                          _editButtonPressed = false;
                                        });
                                      },
                                    );
                                  },
                                  pressed: _editButtonPressed,
                                  child: const Icon(
                                    Icons.edit_outlined,
                                    color: Colors.blue,
                                    size: 24,
                                  ),
                                );
                              }
                          ),
                          StatefulBuilder(
                              builder: (context, setState) {
                                return NeumorphicButton(
                                  onTap: () async {
                                    await Share.shareFiles([path], text: "Share $title to");
                                    setState(() {
                                      _shareButtonPressed = true;
                                    });
                                    Future.delayed(const Duration(milliseconds: 500),
                                          () {
                                        setState(() {
                                          _shareButtonPressed = false;
                                        });
                                      },
                                    );
                                  },
                                  pressed: _shareButtonPressed,
                                  child: const Icon(
                                    Icons.share_outlined,
                                    color: Colors.blue,
                                    size: 24,
                                  ),
                                );
                              }
                          ),
                          StatefulBuilder(
                              builder: (context, setState) {
                                return NeumorphicButton(
                                  onTap: () {
                                    if (arts.contains(this)) {
                                      arts.remove(this);
                                    }
                                    saveAppData();
                                    rebuildMainView();
                                    setState(() {
                                      _deleteButtonPressed = true;
                                    });
                                    Future.delayed(const Duration(milliseconds: 500),
                                          () {
                                        setState(() {
                                          _deleteButtonPressed = false;
                                        });
                                      },
                                    );
                                    Navigator.pop(context);
                                  },
                                  pressed: _deleteButtonPressed,
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.blue,
                                    size: 24,
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 26.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFA3B1C6),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: "Itim",
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NeumorphicButton extends StatelessWidget {
  final bool pressed;
  final Widget child;
  final VoidCallback onTap;

  const NeumorphicButton({super.key, required this.pressed, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: pressed ? Colors.white : const Color(0xFFEFF0F3),
          borderRadius: BorderRadius.circular(10),
          boxShadow: pressed
              ? []
              : [
                  const BoxShadow(
                    color: Colors.white,
                    blurRadius: 30,
                    offset: Offset(-20, -10),
                  ),
                  const BoxShadow(
                    color: Color(0xFFA3B1C6),
                    blurRadius: 30,
                    offset: Offset(20, 20),
                  ),
                ],
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
