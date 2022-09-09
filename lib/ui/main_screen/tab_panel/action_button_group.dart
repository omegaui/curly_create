
import 'package:curly_create/io/app_data_manager.dart';
import 'package:curly_create/ui/camera_screen/camera_view.dart';
import 'package:curly_create/ui/search_screen/search_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ActionButtonGroup extends StatelessWidget{

  final bool searchEnabled;

  const ActionButtonGroup({Key? key, required this.searchEnabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
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
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Material(
                  color: Colors.blue,
                  child: searchEnabled ? IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (builder) => const SearchView()));
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 20,
                    ),
                    splashColor: Colors.white.withOpacity(0.25),
                    splashRadius: 25,
                  ) : Lottie.asset('assets/3315-collection-animation.json', width: 45, height: 45),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Material(
                  color: Colors.blue,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (builder) => const CameraView()));
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

