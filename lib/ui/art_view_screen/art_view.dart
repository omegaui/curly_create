
import 'package:curly_create/io/resource_manager.dart';
import 'package:curly_create/ui/art_view_screen/top_panel/top_panel.dart';
import 'package:curly_create/widgets/art_viewer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

import '../../io/app_data_manager.dart';
import '../../io/art_data.dart';
import '../art_edit_screen/art_edit.dart';

class ArtView extends StatelessWidget {

  final ArtData artData;

  const ArtView({Key? key, required this.artData}) : super(key: key);

  Future<void> share() async {
    await Share.shareFiles([artData.path], text: "Share ${artData.title} to");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const TopPanel(),
              Stack(
                children: [
                  Hero(
                    tag: 'art-${arts.indexOf(artData)}',
                    child: ArtViewer(artData: artData, compactMode: false),
                  ),
                  SizedBox(
                    width: 205,
                    height: 275,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (builder) => ArtEditView(artData: artData)));
                            },
                            style: TextButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )
                            ),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 6,
                                    spreadRadius: 6,
                                  )
                                ],
                              ),
                              child: const Icon(
                                Icons.edit_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 30,
                child: Text(
                  artData.title,
                  style: const TextStyle(
                    fontFamily: "Itim",
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                        child: Text(
                          artData.description.isEmpty ? "No Description Provided" : artData.description,
                          style: const TextStyle(
                            fontFamily: "Itim",
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        artData.note.isEmpty ? "No Notes Attached" : artData.note,
                        style: const TextStyle(
                          fontFamily: "Itim",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: 250,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFFDFDFDF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/92530-error-hide-and-seek.json', width: 48, height: 48),
                    const Text(
                      "share to",
                      style: TextStyle(
                        fontFamily: "Itim",
                        fontSize: 18,
                      ),
                    ),
                    Wrap(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () async {
                                share();
                              },
                              icon: const Image(
                                image: instagram,
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () async {
                                share();
                              },
                              icon: const Image(
                                image: whatsapp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Lottie.asset(
                "assets/17720-landscape.json",
                height: 155,
              ),
            ],
          ),
        ),
      ),
    );
  }

}