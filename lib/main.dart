import 'package:camera/camera.dart';
import 'package:curly_create/io/app_data_manager.dart';
import 'package:curly_create/io/authentication.dart';
import 'package:curly_create/ui/main_screen/main_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

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
      home: Scaffold(
        body: ContentPane(key: contentPaneKey),
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

  void setPage(int index) {
    setState(() {
      viewIndex = index;
    });
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

      await initAppData();
      firebaseApp = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      if (loggedIn) {
        if (FirebaseAuth.instance.currentUser == null) {
          showInSnackBar(context, "Auto Login Failed!");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MainView(key: mainViewKey, page: viewIndex),
    );
  }
}
