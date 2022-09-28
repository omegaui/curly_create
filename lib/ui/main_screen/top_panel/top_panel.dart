import 'dart:io';

import 'package:curly_create/io/app_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:lottie/lottie.dart';

import '../../../io/art_data.dart';
import '../../../io/resource_manager.dart';
import '../../../widgets/logo.dart';

class TopPanel extends StatefulWidget {
  const TopPanel({Key? key}) : super(key: key);

  @override
  State<TopPanel> createState() => TopPanelState();
}

class TopPanelState extends State<TopPanel> {
  void rebuild() {
    setState(() {});
  }

  List<Widget> _buildImageSlideShow() {
    List<GestureDetector> images = [];
    List<ArtData> tempArts = arts.toList();
    tempArts.shuffle();

    if (tempArts.isNotEmpty) {
      for (var i = 0; i < tempArts.length && i <= 3; i++) {
        images.add(GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => Scaffold(
                            body: Container(
                          color: Colors.black,
                          child: Hero(
                            tag:
                                'top-art-element-${arts.indexOf(tempArts.elementAt(i))}',
                            child: GestureDetector(
                              child: InteractiveViewer(
                                panEnabled: true,
                                child: Image.file(
                                  File(tempArts.elementAt(i).path),
                                  fit: BoxFit.fitWidth,
                                  height: double.infinity,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ),
                        ))));
          },
          onVerticalDragEnd: (details) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => Scaffold(
                            body: Container(
                          color: Colors.black,
                          child: Hero(
                            tag:
                                'top-art-element-${arts.indexOf(tempArts.elementAt(i))}',
                            child: InteractiveViewer(
                              panEnabled: true,
                              child: Image.file(
                                File(tempArts.elementAt(i).path),
                                fit: BoxFit.fitWidth,
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                        ))));
          },
          child: Hero(
            tag: 'top-art-element-${arts.indexOf(tempArts.elementAt(i))}',
            child: FadeInImage(
              placeholder: pluto,
              image: FileImage(File(tempArts.elementAt(i).path)),
              fit: BoxFit.fitWidth,
            ),
          ),
        ));
      }
    } else {
      images.add(
        GestureDetector(
          child: Center(
              child: Logo(
            scale: 2,
          )),
        ),
      );
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('normal'),
      height: 220,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          ImageSlideshow(
            width: MediaQuery.of(context).size.width,
            height: 260,
            initialPage: 0,
            indicatorColor: Colors.white,
            indicatorBackgroundColor: Colors.grey.withOpacity(0.5),
            autoPlayInterval: 10000,
            isLoop: arts.isEmpty ? false : true,
            children: _buildImageSlideShow(),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
              child: Container(
                child: arts.isNotEmpty
                    ? Lottie.asset('assets/78625-le-petit-chat-cat-noir.json',
                        width: 70, height: 70)
                    : Lottie.asset('assets/80394-swing-under-the-tree.json',
                        width: 70),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
