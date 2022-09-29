import 'dart:io';

import 'package:curly_create/io/app_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../io/art_data.dart';
import '../../../io/authentication.dart';
import '../../../io/resource_manager.dart';
import '../../../main.dart';
import '../../../widgets/logo.dart';
import '../../info_dialog.dart';

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
              placeholder: defaultIllustration,
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
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Material(
                            child: IconButton(
                              tooltip: "Report a Bug",
                              onPressed: () async {
                                Uri url = Uri.parse(
                                    'https://github.com/omegaui/curly_create/issues/new');
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                              },
                              icon: Icon(
                                Icons.outlined_flag,
                                color: Colors.grey.shade700,
                              ),
                              iconSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                onPressed: () {
                                  showInfoDialog(context);
                                },
                                icon: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Lottie.asset(
                                      'assets/33321-cute-owl.json'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Material(
                            child: IconButton(
                              tooltip: "Sign Out",
                              onPressed: () async {
                                loggedIn = false;
                                if (guestMode) {
                                  await Authentication.signOut(
                                      context: context);
                                }
                                await prefs?.setBool('logged-in', false);
                                await prefs?.setBool('guest-mode', false);
                                guestMode = false;
                                mainViewKey.currentState?.rebuild();
                              },
                              icon: Icon(
                                Icons.logout,
                                color: Colors.grey.shade700,
                              ),
                              iconSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Logo(
                          scale: 1.5,
                        ),
                        const Text(
                          "version 1.2-stable",
                          style: TextStyle(
                            fontFamily: "Itim",
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
