import 'package:curly_create/io/art_data.dart';
import 'package:curly_create/ui/art_edit_screen/tile_wave_picker.dart';
import 'package:curly_create/widgets/art_viewer.dart';
import 'package:flutter/material.dart';

import '../../../io/app_data_manager.dart';
import '../../art_view_screen/art_view.dart';

class ArtCard extends StatefulWidget {
  final ArtData artData;

  const ArtCard({Key? key, required this.artData}) : super(key: key);

  @override
  State<ArtCard> createState() => _ArtCardState();
}

class _ArtCardState extends State<ArtCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => ArtView(artData: widget.artData)));
      },
      child: Container(
        width: (MediaQuery.of(context).size.width / 2 - 20),
        height: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Image(
                  image: widget.artData.getTileWaveData(),
                  fit: BoxFit.fitHeight,
                ),
              ),
            )),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    ArtViewer(artData: widget.artData, compactMode: true),
                    const SizedBox(height: 20),
                    Text(
                      widget.artData.title,
                      style: const TextStyle(
                        fontFamily: "Itim",
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
