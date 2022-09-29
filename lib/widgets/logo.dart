import 'package:curly_create/io/resource_manager.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  double? scale;

  Logo({Key? key, this.scale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    scale ??= 1;
    double sc = scale as double;
    return SizedBox(
      width: 153 * sc,
      height: 85 * sc,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (rect) => const LinearGradient(
                        colors: [Color(0xFF232323), Color(0xab454545)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)
                    .createShader(rect),
                child: Text(
                  "Curly",
                  style: TextStyle(
                    fontFamily: "IrishGrover",
                    fontSize: 32 * sc,
                  ),
                ),
              ),
              Image(
                image: curlyCreateBrush,
                width: 48 * sc,
                height: 48 * sc,
              ),
            ],
          ),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (rect) => const LinearGradient(
                    colors: [Color(0xab454545), Color(0xFF232323)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)
                .createShader(rect),
            child: Text(
              "Create",
              style: TextStyle(
                fontFamily: "IrishGrover",
                fontSize: 28 * sc,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
