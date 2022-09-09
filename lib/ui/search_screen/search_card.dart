
import 'package:curly_create/io/art_data.dart';
import 'package:curly_create/ui/art_view_screen/art_view.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget{

  final ArtData artData;

  const SearchCard({Key? key, required this.artData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) => ArtView(artData: artData)));
        },
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              Text(
                artData.title,
                style: TextStyle(
                  fontFamily: "Itim",
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

