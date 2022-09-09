
import 'package:curly_create/ui/backup_screen/backup_card.dart';
import 'package:flutter/material.dart';

import '../../io/app_data_manager.dart';
import '../main_screen/main_view.dart';

class BackupPanel extends StatefulWidget{
  const BackupPanel({Key? key}) : super(key: key);

  @override
  State<BackupPanel> createState() => BackupPanelState();
}

class BackupPanelState extends State<BackupPanel> {

  bool startBackup = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels == 0){
        tabPanelKey.currentState?.setVisible(true);
      }
      else{
        tabPanelKey.currentState?.setVisible(false);
      }
    });
  }

  void checkForBackup(){
    setState(() {
      startBackup = true;
    });
  }

  void rebuild(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: arts.map((e) => BackupCard(artData: e, backupActive: startBackup)).toList(),
        ),
      ),
    );
  }
}


