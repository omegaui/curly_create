import 'dart:async';

import 'package:camera/camera.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curly_create/io/app_data_manager.dart';
import 'package:curly_create/io/authentication.dart';
import 'package:curly_create/ui/backup_screen/backup_view.dart';
import 'package:curly_create/ui/backup_screen/download_panel.dart';
import 'package:curly_create/ui/main_screen/main_view.dart';
import 'package:curly_create/widgets/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:slide_drawer/slide_drawer.dart';

import 'firebase_options.dart';

GlobalKey<ContentPaneState> contentPaneKey = GlobalKey();
GlobalKey<MainViewState> mainViewKey = GlobalKey();
late FirebaseApp firebaseApp;

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SlideDrawer(
        backgroundColor: const Color(0xFFEFF0F3),
        contentDrawer: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF0F3),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
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
            child: Column(
              children: [
                const SizedBox(height: 120),
                Logo(scale: 1.2),
                Text(
                  "version $version-stable",
                  style: TextStyle(
                    fontFamily: "Itim",
                    color: Colors.grey.shade700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
                FutureBuilder(
                  future: initFlutterInsta(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Lottie.asset('assets/97952-loading-animation-blue.json', width: 60, height: 60);
                    }
                    else if(snapshot.hasError && followers == null){
                      return Column(
                        children: [
                          Text(
                            "Instagram API (connection denied)",
                            style: TextStyle(
                              fontFamily: "Itim",
                              color: Colors.grey.shade700,
                              fontSize: 12,
                            ),
                          ),
                          Lottie.asset('assets/77495-time-loading.json', width: 80),
                          Text(
                            "Come back later!",
                            style: TextStyle(
                              fontFamily: "Itim",
                              color: Colors.grey.shade700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${flutterInsta.followers} ",
                              style: TextStyle(
                                fontFamily: "Itim",
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "followers",
                              style: TextStyle(
                                fontFamily: "Itim",
                                color: Colors.grey.shade700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        if(followers != null && snapshot.hasError)
                          Text(
                            "(last fetched count)",
                            style: TextStyle(
                              fontFamily: "Itim",
                              color: Colors.grey.shade700,
                              fontSize: 12,
                            ),
                          ),
                        Lottie.asset('assets/48713-media-people.json'),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        child: ContentPane(key: contentPaneKey),
      ),
    );
  }
}

class ContentPane extends StatefulWidget {
  const ContentPane({Key? key}) : super(key: key);

  @override
  State<ContentPane> createState() => ContentPaneState();
}

class ContentPaneState extends State<ContentPane> {
  int viewIndex = 0;
  StreamSubscription<ConnectivityResult>? subscription;

  void setPage(int index) {
    if(viewIndex == index){
      return;
    }
    setState(() {
      viewIndex = index;
    });
    if(viewIndex == 1){
      backupPanelKey.currentState?.rebuild();
    }
  }

  void rebuild() {
    setState(() {
      viewIndex = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ));

      await Permission.storage.request();
      await Permission.camera.request();

      firebaseApp = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      if (loggedIn) {
        if (FirebaseAuth.instance.currentUser == null) {
          showInSnackBar(context, "Auto Login Failed!");
        }
      }

      await initAppData();
      await loadAll();

      subscription = Connectivity().onConnectivityChanged.listen((event) {
        if(event != ConnectivityResult.none) {
          mainViewKey.currentState?.rebuild();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MainView(key: mainViewKey, page: viewIndex),
    );
  }
}
