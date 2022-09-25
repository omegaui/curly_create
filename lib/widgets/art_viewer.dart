import 'dart:io';

import 'package:curly_create/io/art_data.dart';
import 'package:flutter/material.dart';

import '../io/resource_manager.dart';

class ArtViewer extends StatelessWidget {
  final ArtData artData;
  final bool compactMode;

  const ArtViewer({Key? key, required this.artData, required this.compactMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => Scaffold(
                        body: Container(
                          color: Colors.black,
                          child: InteractiveViewer(
                            panEnabled: true,
                            child: Image.file(
                      File(artData.path),
                      fit: BoxFit.fitWidth,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                          ),
                        ))));
      },
      child: Container(
        width: compactMode ? 209.45 / 1.9 : 209.45,
        height: compactMode ? 279.45 / 1.9 : 279.45,
        decoration: BoxDecoration(
          color: artData.getTileColor(),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: FadeInImage(
            placeholder: illustration,
            image: FileImage(File(artData.path)),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
