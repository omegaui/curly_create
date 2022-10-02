import 'package:flutter/material.dart';

import '../../io/art_data.dart';
import '../../io/resource_manager.dart';

class TileWavePicker extends StatefulWidget {
  final ArtData artData;
  final Function(int) onPick;

  const TileWavePicker({Key? key, required this.onPick, required this.artData})
      : super(key: key);

  @override
  State<TileWavePicker> createState() => _TileWavePickerState();
}

class _TileWavePickerState extends State<TileWavePicker> {
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
              WaveBall(
                  tileWave: getTileWave(0),
                  onPick: () {
                    setState(() {
                      selection = 0;
                    });
                    widget.onPick.call(0);
                  },
                  active: selection == 0),
              WaveBall(
                  tileWave: getTileWave(1),
                  onPick: () {
                    setState(() {
                      selection = 1;
                    });
                    widget.onPick.call(1);
                  },
                  active: selection == 1),
              WaveBall(
                  tileWave: getTileWave(2),
                  onPick: () {
                    setState(() {
                      selection = 2;
                    });
                    widget.onPick.call(2);
                  },
                  active: selection == 2),
              WaveBall(
                  tileWave: getTileWave(3),
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

class WaveBall extends StatelessWidget {
  final ImageProvider tileWave;
  final VoidCallback onPick;
  final bool active;

  const WaveBall(
      {Key? key,
      required this.tileWave,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.yellow.shade900.withOpacity(0.5),
              blurRadius: active ? 2 : 0,
              spreadRadius: active ? 2 : 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image(image: tileWave, fit: BoxFit.fill),
        ),
      ),
    );
  }
}

ImageProvider getTileWave(int colorTileIndex) {
  if (colorTileIndex == 0) {
    return vectorWave1;
  } else if (colorTileIndex == 1) {
    return vectorWave2;
  } else if (colorTileIndex == 2) {
    return vectorWave3;
  }
  return vectorWave4;
}


