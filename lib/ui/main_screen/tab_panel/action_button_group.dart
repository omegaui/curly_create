import 'package:curly_create/io/app_data_manager.dart';
import 'package:curly_create/ui/camera_screen/camera_view.dart';
import 'package:curly_create/ui/search_screen/search_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ActionButtonGroup extends StatelessWidget {
  final bool searchEnabled;

  const ActionButtonGroup({Key? key, required this.searchEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: guestMode ? 60 : 150,
        height: 60,
        decoration: !guestMode
            ? BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                  BoxShadow(
                    color: Color(0xFFA3B1C6),
                    blurRadius: 20,
                    offset: Offset(0, 5),
                  ),
                ],
              )
            : BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              blurRadius: 4,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Wrap(
            spacing: 2,
            children: [
              if (!guestMode)
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Material(
                    color: Colors.blue,
                    child: IconButton(
                      onPressed: () async {
                        await pickArts(context);
                      },
                      icon: const Icon(
                        Icons.add_photo_alternate_outlined,
                        color: Colors.white,
                      ),
                      splashColor: Colors.white.withOpacity(0.25),
                      splashRadius: 32,
                    ),
                  ),
                ),
              if(searchEnabled)
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Material(
                    color: Colors.blue,
                    child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => const SearchView()));
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 20,
                            ),
                            splashColor: Colors.white.withOpacity(0.25),
                            splashRadius: 25,
                          ),
                  ),
                ),
              if (!guestMode)
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Material(
                    color: Colors.blue,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const CameraView()));
                      },
                      icon: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: const Icon(
                          Icons.camera,
                          color: Colors.white,
                        ),
                      ),
                      splashColor: Colors.white.withOpacity(0.25),
                      splashRadius: 32,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
