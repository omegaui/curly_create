import 'package:curly_create/ui/art_edit_screen/art_edit.dart';
import 'package:curly_create/ui/main_screen/main_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'art_data.dart';

SharedPreferences? prefs;
bool loggedIn = false;
bool guestMode = false;
bool firstStartup = true;

List<ArtData> arts = [];

FlutterInsta flutterInsta = FlutterInsta();
String? followers;

Future<void> initAppData() async {
  prefs = await SharedPreferences.getInstance();
  loggedIn = prefs?.getBool('logged-in') ?? false;
  guestMode = prefs?.getBool('guest-mode') ?? false;
  firstStartup = prefs?.getBool('first-startup') ?? true;
  List<String>? titles = prefs?.getStringList('titles');
  if (titles != null && titles.isNotEmpty) {
    Fluttertoast.showToast(
      msg: ">_ Optimizing Performance",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.grey.shade800,
      fontSize: 12.0,
    );
    List<String>? colorTileIndexes = prefs?.getStringList('colorTileIndexes');
    List<String>? paths = prefs?.getStringList('paths');
    List<String>? descriptions = prefs?.getStringList('descriptions');
    List<String>? notes = prefs?.getStringList('notes');
    if (colorTileIndexes != null &&
        paths != null &&
        descriptions != null &&
        notes != null) {
      int len = titles.length;
      for (var i = 0; i < len; i++) {
        var artData = ArtData(
            titles.elementAt(i),
            int.parse(colorTileIndexes.elementAt(i)),
            paths.elementAt(i),
            descriptions.elementAt(i),
            notes.elementAt(i));
        arts.add(artData);
      }
    }
  }
  rebuildMainView();
}

Future<void> initFlutterInsta() async {
  await flutterInsta.getProfileData('curly_create');
  followers = flutterInsta.followers;
}

Future<void> saveAppData() async {
  List<String> titles = [];
  List<String> colorTileIndexes = [];
  List<String> paths = [];
  List<String> descriptions = [];
  List<String> notes = [];
  for (var data in arts) {
    titles.add(data.title);
    colorTileIndexes.add(data.colorTileIndex.toString());
    paths.add(data.path);
    descriptions.add(data.description);
    notes.add(data.note);
  }
  await prefs?.setStringList('titles', titles);
  await prefs?.setStringList('colorTileIndexes', colorTileIndexes);
  await prefs?.setStringList('paths', paths);
  await prefs?.setStringList('descriptions', descriptions);
  await prefs?.setStringList('notes', notes);
}

Future<void> pickArts(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    dialogTitle: "Pick Art",
    type: FileType.image,
  );
  if (result != null) {
    for (var file in result.files) {
      var data = ArtData("", 0, file.path as String, "", "");
      Navigator.push(context,
          MaterialPageRoute(builder: (builder) => ArtEditView(artData: data)));
    }
  }
}
