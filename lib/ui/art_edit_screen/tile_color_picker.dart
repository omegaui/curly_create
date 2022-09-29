import 'package:flutter/material.dart';

import '../../io/art_data.dart';

class TileColorPicker extends StatefulWidget {
  final ArtData artData;
  final Function(int) onPick;

  const TileColorPicker({Key? key, required this.onPick, required this.artData})
      : super(key: key);

  @override
  State<TileColorPicker> createState() => _TileColorPickerState();
}

class _TileColorPickerState extends State<TileColorPicker> {
  int selection = 0;

  @override
  void initState() {
    selection = widget.artData.colorTileIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0x28D9D9D9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            spacing: 4,
            children: [
              ColorBall(
                  tileColor: getTileColor(0),
                  onPick: () {
                    setState(() {
                      selection = 0;
                    });
                    widget.onPick.call(0);
                  },
                  active: selection == 0),
              ColorBall(
                  tileColor: getTileColor(1),
                  onPick: () {
                    setState(() {
                      selection = 1;
                    });
                    widget.onPick.call(1);
                  },
                  active: selection == 1),
              ColorBall(
                  tileColor: getTileColor(2),
                  onPick: () {
                    setState(() {
                      selection = 2;
                    });
                    widget.onPick.call(2);
                  },
                  active: selection == 2),
              ColorBall(
                  tileColor: getTileColor(3),
                  onPick: () {
                    setState(() {
                      selection = 3;
                    });
                    widget.onPick.call(3);
                  },
                  active: selection == 3),
            ],
          ),
        ],
      ),
    );
  }
}

class ColorBall extends StatelessWidget {
  final Color tileColor;
  final VoidCallback onPick;
  final bool active;

  const ColorBall(
      {Key? key,
      required this.tileColor,
      required this.onPick,
      required this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.yellow.shade900.withOpacity(0.5),
              blurRadius: active ? 2 : 0,
              spreadRadius: active ? 2 : 0,
            ),
          ],
        ),
      ),
    );
  }
}

Color getTileColor(int colorTileIndex) {
  if (colorTileIndex == 0) {
    return const Color(0xFFEFEFEF);
  } else if (colorTileIndex == 1) {
    return const Color(0xFFFFFFFF);
  } else if (colorTileIndex == 3) {
    return const Color(0xFFBDBDBD);
  }
  return const Color(0xFFDFDFDF);
}
