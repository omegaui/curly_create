
import 'package:flutter/material.dart';

class ArtData {
  String title;
  int colorTileIndex;
  final String path;
  String description;
  String note;

  ArtData(this.title, this.colorTileIndex, this.path, this.description, this.note);

  Color getTileColor(){
    if(colorTileIndex == 0){
      return const Color(0xFFEFEFEF);
    }
    else if(colorTileIndex == 1){
      return const Color(0xFFFFFFFF);
    }
    else if(colorTileIndex == 3){
      return const Color(0xFFBDBDBD);
    }
    return const Color(0xFFDFDFDF);
  }


  @override
  String toString(){
    return "{\"title\": \"$title\", \"colorTileIndex\": $colorTileIndex, \"path\": \"$path\", \"description\": \"$description\", \"note\": \"$note\"}";
  }
}


