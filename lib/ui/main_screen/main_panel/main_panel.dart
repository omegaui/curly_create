
import 'package:curly_create/io/app_data_manager.dart';
import 'package:curly_create/ui/main_screen/main_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../io/resource_manager.dart';
import 'art_card.dart';

class MainPanel extends StatefulWidget{
  const MainPanel({Key? key}) : super(key: key);

  @override
  State<MainPanel> createState() => MainPanelState();
}

class MainPanelState extends State<MainPanel> {

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels == 0){
        tabPanelKey.currentState?.setVisible(true);
      }
      else{
        tabPanelKey.currentState?.setVisible(false);
      }
    });
  }

  void rebuild(){
    setState(() {});
  }

  List<Widget> _buildArtCards(){
    List<Padding> rows = [];
    if(arts.length > 1) {
      for (var i = 0; i < arts.length - 1; i+=2) {
        rows.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(tag: 'art-$i', child: ArtCard(artData: arts.elementAt(i))),
                const SizedBox(width: 10),
                Hero(tag: 'art-${i + 1}', child: ArtCard(artData: arts.elementAt(i+1))),
              ],
            ),
          ),
        );
      }
      if(arts.length % 2 == 1){
        rows.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(tag: 'art-${arts.length - 1}', child: ArtCard(artData: arts.last)),
              ],
            ),
          ),
        );
      }
    }
    else if(arts.length == 1){
      rows.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(tag: 'art-0', child: ArtCard(artData: arts.elementAt(0))),
            ],
          ),
        ),
      );
    }
    else{
      rows.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/63534-image-preloader.json'),
              const Text(
                "Add your Arts to list them here",
                style: TextStyle(
                  fontFamily: "Itim",
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                  onPressed: () async {
                    await pickArts(context);
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.cyan.withOpacity(0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Image(
                    image: newDrawingImage,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 150 - 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: _buildArtCards(),
            ),
          ),
        ),
      ),
    );
  }
}

