import 'package:cached_network_image/cached_network_image.dart';
import 'package:curly_create/io/art_data.dart';
import 'package:curly_create/ui/backup_screen/download_panel.dart';
import 'package:curly_create/widgets/art_viewer.dart';
import 'package:flutter/material.dart';

import '../../../io/resource_manager.dart';
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
    bool onRemote = isPresentOnRemoteServer(widget.artData);
    return GestureDetector(
      onLongPress: () => widget.artData.showActionSheet(context),
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
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFEFF0F3),
              blurRadius: 30,
              offset: Offset(-20, -20),
            ),
            BoxShadow(
              color: Color(0xFFA3B1C6),
              blurRadius: 30,
              offset: Offset(20, 20),
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
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF0F3),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 30,
                            offset: Offset(-20, -10),
                          ),
                          BoxShadow(
                            color: Color(0xFFA3B1C6),
                            blurRadius: 30,
                            offset: Offset(20, 20),
                          ),
                        ],
                      ),
                      child:
                          ArtViewer(artData: widget.artData, compactMode: true),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.artData.title,
                          style: const TextStyle(
                            fontFamily: "Itim",
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  if (!loadedRemotes)
                    const Image(image: loading, width: 20, height: 20),
                  if (loadedRemotes)
                    CachedNetworkImage(
                      imageUrl: onRemote
                          ? 'https://img.icons8.com/fluency/48/000000/instagram-check-mark.png'
                          : 'https://img.icons8.com/external-dreamcreateicons-outline-color-dreamcreateicons/48/000000/external-alert-internet-security-dreamcreateicons-outline-color-dreamcreateicons-2.png',
                      placeholder: (context, url) =>
                          const Image(image: loading, width: 20, height: 20),
                      errorWidget: (context, url, error) =>
                          const Image(image: network, width: 20, height: 20),
                      width: 20,
                      height: 20,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//97952-loading-animation-blue.json
