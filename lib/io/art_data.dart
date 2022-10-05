import 'dart:io';

import 'package:curly_create/ui/art_edit_screen/tile_wave_picker.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ArtData {
  String title;
  int colorTileIndex;
  final String path;
  String description;
  String note;
  late FileImage image;
  late PaletteGenerator paletteGenerator;

  ArtData(
      this.title, this.colorTileIndex, this.path, this.description, this.note) {
    image = FileImage(File(path));
  }

  Future<void> initPalette() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(image);
  }

  ImageProvider getTileWaveData() {
    return getTileWave(colorTileIndex);
  }

  @override
  String toString() {
    return "{\"title\": \"$title\", \"colorTileIndex\": $colorTileIndex, \"path\": \"$path\", \"description\": \"$description\", \"note\": \"$note\"}";
  }
}
