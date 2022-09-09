
import '../../io/app_data_manager.dart';
import 'package:curly_create/ui/backup_screen/backup_view.dart';
import 'package:curly_create/ui/welcome_screen/welcome_view.dart';
import 'package:flutter/material.dart';

import 'main_panel/main_panel.dart';
import 'tab_panel/tab_panel.dart';
import 'top_panel/top_panel.dart';

GlobalKey<MainPanelState> mainPanelKey = GlobalKey();
GlobalKey<TopPanelState> topPanelKey = GlobalKey();
GlobalKey<TabPanelState> tabPanelKey = GlobalKey();

void rebuildMainView(){
  mainPanelKey.currentState?.rebuild();
  topPanelKey.currentState?.rebuild();
  tabPanelKey.currentState?.rebuild();
}

class MainView extends StatefulWidget{

  final int page;
  const MainView({Key? key, required this.page}) : super(key: key);

  @override
  State<MainView> createState() => MainViewState();
}

class MainViewState extends State<MainView> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            if(widget.page == 0)
              Column(
                children: [
                  TopPanel(key: topPanelKey),
                  MainPanel(key: mainPanelKey),
                ],
              ),
            if(widget.page == 1)
              Column(
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
      ),
    );
  }
}





