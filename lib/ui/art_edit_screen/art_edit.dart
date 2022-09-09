
import 'package:curly_create/io/app_data_manager.dart';
import 'package:curly_create/io/resource_manager.dart';
import 'package:curly_create/ui/art_edit_screen/tile_color_picker.dart';
import 'package:curly_create/ui/art_edit_screen/top_panel/top_panel.dart';
import 'package:curly_create/ui/main_screen/main_view.dart';
import 'package:curly_create/io/authentication.dart';
import 'package:curly_create/widgets/art_viewer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../io/art_data.dart';

class ArtEditView extends StatelessWidget {
  
  final ArtData artData;
  TextEditingController? titleFieldController;
  TextEditingController? descriptionFieldController;
  TextEditingController? noteFieldController;
  
  ArtEditView({Key? key, required this.artData}) : super(key: key) {
    titleFieldController = TextEditingController(text: artData.title);
    descriptionFieldController = TextEditingController(text: artData.description);
    noteFieldController = TextEditingController(text: artData.note);
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
              const SizedBox(height: 10),
              Hero(
                tag: 'art-${arts.indexOf(artData)}',
                child: ArtViewer(artData: artData, compactMode: false),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: titleFieldController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Itim",
                  fontSize: 20,
                ),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontFamily: "Itim",
                    fontSize: 20,
                    color: Colors.grey.shade500,
                  ),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: descriptionFieldController,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontFamily: "Itim",
                        fontSize: 14,
                      ),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        hintText: "Description",
                        hintStyle: TextStyle(
                          fontFamily: "Itim",
                          color: Colors.grey.shade500,
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                      ),
                    ),
                    TextField(
                      controller: noteFieldController,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontFamily: "Itim",
                        fontSize: 14,
                      ),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        hintText: "Note",
                        hintStyle: TextStyle(
                          fontFamily: "Itim",
                          color: Colors.grey.shade500,
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          "Tile Color",
                          style: TextStyle(
                            fontFamily: "Itim",
                            color: Colors.grey.shade900
                          ),
                        ),
                        const SizedBox(width: 10),
                        TileColorPicker(onPick: (index) {
                          artData.colorTileIndex = index;
                        }, artData: artData),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Material(
                      child: IconButton(
                        tooltip: "Done",
                        onPressed: () async {
                          if(titleFieldController?.text.isEmpty as bool){
                            showInSnackBar(context, "Title cannot be empty, it is essential for creating backups!");
                            return;
                          }
                          artData.title = titleFieldController?.text as String;
                          artData.description = descriptionFieldController?.text as String;
                          artData.note = noteFieldController?.text as String;

                          if(!arts.contains(artData)){
                            arts.add(artData);
                          }

                          saveAppData();
                          rebuildMainView();
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.done_outline_sharp,
                          color: Colors.green,
                        ),
                        splashColor: Colors.green.withOpacity(0.25),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Material(
                      child: IconButton(
                        tooltip: "Remove from Collections",
                        onPressed: () async {
                          if(arts.contains(artData)){
                            arts.remove(artData);
                          }
                          saveAppData();
                          rebuildMainView();
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.pink,
                        ),
                        splashColor: Colors.pink.withOpacity(0.25),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Material(
                      child: IconButton(
                        tooltip: "Cancel",
                        onPressed: () {
                          rebuildMainView();
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close_outlined,
                          color: Colors.red,
                        ),
                        splashColor: Colors.red.withOpacity(0.25),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Lottie.asset(
                "assets/88720-painting.json",
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

}