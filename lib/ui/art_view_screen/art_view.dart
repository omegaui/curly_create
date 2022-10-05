
import 'package:flutter/material.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

import '../../io/app_data_manager.dart';
import '../../io/art_data.dart';
import '../art_edit_screen/art_edit.dart';

class ArtView extends StatelessWidget {
  final ArtData artData;

  ArtView({Key? key, required this.artData}) : super(key: key);

  Future<void> share() async {
    await Share.shareFiles([artData.path], text: "Share ${artData.title} to");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImagePixels(
                    imageProvider: artData.image,
                    builder: (context, img) {
                      Color dx = img.pixelColorAt!(0,0);
                      Color color = artData.paletteGenerator.darkVibrantColor?.color as Color;
                      return Hero(
                        tag: 'art-${arts.indexOf(artData)}',
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 450,
                          decoration: BoxDecoration(
                            color: dx,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image(
                                        image: artData.image,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: artData.paletteGenerator.lightMutedColor?.color,
                                        ),
                                        splashColor: color,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Material(
                                      color: artData.paletteGenerator.mutedColor?.color.withOpacity(0.2),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ArtEditView(artData: artData)));
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          size: 16,
                                          color: artData.paletteGenerator.lightMutedColor?.color,
                                        ),
                                        splashColor: color,
                                        splashRadius: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: IconButton(
                                        onPressed: () async {
                                          await share();
                                        },
                                        icon: Icon(
                                          Icons.share,
                                          size: 16,
                                          color: artData.paletteGenerator.lightMutedColor?.color,
                                        ),
                                        splashColor: color,
                                        splashRadius: 20,
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
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      artData.title,
                      style: const TextStyle(
                        fontFamily: 'Itim',
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    SizedBox(
                      height: 16,
                      child: Text(
                        artData.description.isEmpty
                            ? "No Description Provided"
                            : artData.description,
                        style: const TextStyle(
                          fontFamily: "Itim",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      artData.note.isEmpty
                          ? "No Notes Attached"
                          : artData.note,
                      style: const TextStyle(
                        fontFamily: "Itim",
                      ),
                    ),
                  ],
                ),
                Lottie.asset(
                  "assets/17720-landscape.json",
                  height: 155,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
