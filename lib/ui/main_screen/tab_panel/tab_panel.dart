
import 'package:curly_create/main.dart';
import 'package:curly_create/ui/backup_screen/backup_view.dart';
import 'package:flutter/material.dart';

import '../../../io/app_data_manager.dart';
import 'action_button_group.dart';
import 'tab_button.dart';

class TabPanel extends StatefulWidget{
  const TabPanel({Key? key}) : super(key: key);

  @override
  State<TabPanel> createState() => TabPanelState();
}

class TabPanelState extends State<TabPanel> {

  bool visible = true;

  void setVisible(bool visible){
    setState(() {
      this.visible = visible;
    });
  }

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: visible ? Container(
          key: const Key('normal'),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                blurRadius: 2,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              TabButton(
                active: contentPaneKey.currentState?.viewIndex == 0,
                iconData: Icons.collections,
                title: "collections",
                callback: () {
                  setState(() {
                    contentPaneKey.currentState?.setPage(0);
                  });
                },
              ),
              ActionButtonGroup(searchEnabled: arts.isNotEmpty),
              TabButton(
                active: contentPaneKey.currentState?.viewIndex == 1,
                iconData: Icons.backup_outlined,
                title: guestMode ? "downloads" : "backups",
                callback: () {
                  setState(() {
                    backupPanelKey.currentState?.rebuild();
                    contentPaneKey.currentState?.setPage(1);
                  });
                },
              ),
              const SizedBox(),
            ],
          ),
        ) : const SizedBox(
          key: Key("hidden"),
        ),
      ),
    );
  }
}
