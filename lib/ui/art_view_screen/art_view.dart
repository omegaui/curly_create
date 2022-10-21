
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
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                color: Colors.red,
                height: MediaQuery.of(context).size.height,
                child: Image(
                  image: artData.getTileWaveData(),
                  fit: BoxFit.fitHeight,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                        tag: 'art-${arts.indexOf(artData)}',
                        child: SizedBox(
                          height: 400,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) => Scaffold(
                                                    body: Container(
                                                      color: Colors.white,
                                                      child: InteractiveViewer(
                                                        panEnabled: true,
                                                        child: Image(
                                                          image: artData.image,
                                                          fit: BoxFit.fitWidth,
                                                          height: double.infinity,
                                                          width: double.infinity,
                                                          alignment: Alignment.center,
                                                        ),
                                                      ),
                                                    ))));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEFF0F3),
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 40,
                                              offset: Offset(-20, -20),
                                            ),
                                            BoxShadow(
                                              color: Color(0xFFA3B1C6),
                                              blurRadius: 40,
                                              offset: Offset(20, 20),
                                            ),
                                          ],
                                        ),
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
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFF0F3),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 20,
                                          offset: Offset(-5, -5),
                                        ),
                                        BoxShadow(
                                          color: Color(0xFFA3B1C6),
                                          blurRadius: 20,
                                          offset: Offset(5, 5),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Material(
                                        color: const Color(0xFFEFF0F3),
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: Colors.grey.shade800,
                                          ),
                                          splashColor: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFF0F3),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 20,
                                          offset: Offset(-5, -5),
                                        ),
                                        BoxShadow(
                                          color: Color(0xFFA3B1C6),
                                          blurRadius: 20,
                                          offset: Offset(5, 5),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Material(
                                        color: const Color(0xFFEFF0F3),
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ArtEditView(artData: artData)));
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 28,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFF0F3),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 20,
                                          offset: Offset(-5, -5),
                                        ),
                                        BoxShadow(
                                          color: Color(0xFFA3B1C6),
                                          blurRadius: 20,
                                          offset: Offset(5, 5),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Material(
                                        color: const Color(0xFFEFF0F3),
                                        child: IconButton(
                                          onPressed: () async {
                                            await share();
                                          },
                                          icon: const Icon(
                                            Icons.share,
                                            size: 28,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
