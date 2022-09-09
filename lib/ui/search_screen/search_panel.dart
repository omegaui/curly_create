
import 'package:curly_create/io/app_data_manager.dart';
import 'package:curly_create/ui/search_screen/search_card.dart';
import 'package:curly_create/ui/search_screen/search_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../io/art_data.dart';

class SearchPanel extends StatefulWidget{
  const SearchPanel({Key? key}) : super(key: key);

  @override
  State<SearchPanel> createState() => SearchPanelState();
}

class SearchPanelState extends State<SearchPanel> {

  List<ArtData> searchDataSet = [];

  void search(String text){
    searchDataSet.clear();
    if(text.isNotEmpty) {
      for (var artData in arts) {
        if (artData.title.contains(text)) {
          searchDataSet.add(artData);
        }
      }
    }
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Visibility(
            visible: searchDataSet.isNotEmpty,
            child: Column(
              children: searchDataSet.map((e) => SearchCard(artData: e)).toList(),
            ),
          ),
          Expanded(
            child: Visibility(
              visible: searchDataSet.isEmpty,
              child: searchFieldController.text.isEmpty ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/77218-search-imm.json'),
                  Text(
                    "Start Typing to hunt your awesome arts",
                    style: TextStyle(
                      fontFamily: "Itim",
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ) : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/98312-empty.json'),
                  Text(
                    "Looks like you haven't drawn that yet!",
                    style: TextStyle(
                      fontFamily: "Itim",
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


