import 'package:curly_create/ui/art_edit_screen/tile_wave_picker.dart';
import 'package:flutter/material.dart';

class ArtData {
  String title;
  int colorTileIndex;
  final String path;
  String description;
  String note;

  ArtData(
      this.title, this.colorTileIndex, this.path, this.description, this.note);

  ImageProvider getTileWaveData() {
    return getTileWave(colorTileIndex);
  }


  @override
  String toString() {
    return "{\"title\": \"$title\", \"colorTileIndex\": $colorTileIndex, \"path\": \"$path\", \"description\": \"$description\", \"note\": \"$note\"}";
  }
}
