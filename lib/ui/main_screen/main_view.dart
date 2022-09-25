import 'package:curly_create/main.dart';
import 'package:lottie/lottie.dart';

import '../../io/app_data_manager.dart';
import 'package:curly_create/ui/backup_screen/backup_view.dart';
import 'package:curly_create/ui/welcome_screen/welcome_view.dart';
import 'package:flutter/material.dart';

import '../../io/resource_manager.dart';
import '../info_dialog.dart';
import 'main_panel/main_panel.dart';
import 'tab_panel/tab_panel.dart';
import 'top_panel/top_panel.dart';

GlobalKey<MainPanelState> mainPanelKey = GlobalKey();
GlobalKey<TopPanelState> topPanelKey = GlobalKey();
GlobalKey<TabPanelState> tabPanelKey = GlobalKey();

void rebuildMainView() {
  mainViewKey.currentState?.rebuild();
}

class MainView extends StatefulWidget {
  final int page;
  const MainView({Key? key, required this.page}) : super(key: key);

  @override
  State<MainView> createState() => MainViewState();
}

String getGreeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning,';
  }
  if (hour < 17) {
    return 'Good Afternoon,';
  }
  return 'Good Evening,';
}

class MainViewState extends State<MainView> {

  void rebuild(){
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          if (widget.page == 0)
            Column(
              children: [
                if (arts.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      onPressed: () {
                                        showInfoDialog(context);
                                      },
                                      icon: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: const Image(
                                          image: profileImage,
                                        ),
                                      ),
                                      iconSize: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                getGreeting(),
                                style: const TextStyle(
                                  fontFamily: 'Itim',
                                  fontSize: 20,
                                ),
                              ),
                              const Text(
                                " Parul",
                                style: TextStyle(
                                  fontFamily: 'Itim',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 20,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TopPanel(key: topPanelKey)),
                  ),
                ),
                Expanded(
                  child: MainPanel(key: mainPanelKey),
                ),
              ],
            ),
          if (widget.page == 1)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                BackupView(),
              ],
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabPanel(key: tabPanelKey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
