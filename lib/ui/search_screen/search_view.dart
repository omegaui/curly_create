import 'package:curly_create/ui/search_screen/search_panel.dart';
import 'package:flutter/material.dart';

final GlobalKey<SearchPanelState> searchPanelKey = GlobalKey();
final TextEditingController searchFieldController = TextEditingController();

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_left_rounded,
                            color: Colors.grey.shade800,
                          ),
                          iconSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      child: TextField(
                        controller: searchFieldController,
                        onChanged: (text) {
                          searchPanelKey.currentState?.search(text);
                        },
                        onSubmitted: (text) {
                          searchPanelKey.currentState?.search(text);
                        },
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "Itim",
                        ),
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: "Title",
                          hintStyle: TextStyle(
                            fontFamily: "Itim",
                            color: Colors.grey.shade500,
                          ),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SearchPanel(key: searchPanelKey),
            ],
          ),
        ),
      ),
    );
  }
}
