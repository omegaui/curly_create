import 'package:curly_create/io/authentication.dart';
import 'package:curly_create/io/resource_manager.dart';
import 'package:curly_create/main.dart';
import 'package:curly_create/ui/welcome_screen/start_screen.dart';
import 'package:curly_create/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../io/app_data_manager.dart';
import 'package:curly_create/ui/backup_screen/backup_view.dart';
import 'package:flutter/material.dart';

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
    return 'Good Morning';
  }
  if (hour < 17) {
    return 'Good Afternoon';
  }
  return 'Good Evening';
}

class MainViewState extends State<MainView> {
  bool pressed = false;

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!loggedIn && !guestMode) {
      return const StartScreen();
    }
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Material(
                                  child: IconButton(
                                    tooltip: "Report a Bug",
                                    onPressed: () async {
                                      Uri url = Uri.parse(
                                          'https://github.com/omegaui/curly_create/issues/new');
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.outlined_flag,
                                      color: Colors.grey.shade700,
                                    ),
                                    iconSize: 20,
                                  ),
                                ),
                              ),
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
                                    child: GestureDetector(
                                      onLongPress: () {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: Container(
                                                width: double.infinity,
                                                height: 120,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 100,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Image(
                                                              image: deadpool,
                                                              width: 48,
                                                              height: 48,
                                                            ),
                                                            Text(
                                                              "Yours only enemy",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Itim",
                                                                fontSize: 12,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                color: Colors
                                                                    .grey
                                                                    .shade700,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Center(
                                                          child: VerticalDivider(
                                                              thickness: 2,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.7))),
                                                      SizedBox(
                                                        width: 100,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Logo(scale: 0.7),
                                                            Text(
                                                              "version $version",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Itim",
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey
                                                                    .shade700,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Center(
                                                          child: VerticalDivider(
                                                              thickness: 2,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.7))),
                                                      SizedBox(
                                                        width: 100,
                                                        child: Center(
                                                          child: StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                            return GestureDetector(
                                                              onTap: () async {
                                                                Uri uri = Uri.parse("https://github.com/omegaui/curly_create");
                                                                if(await canLaunchUrl(uri)){
                                                                  launchUrl(uri);
                                                                }
                                                                setState(() {
                                                                  pressed =
                                                                      true;
                                                                });
                                                                Future.delayed(
                                                                    const Duration(
                                                                        milliseconds:
                                                                            500),
                                                                    () {
                                                                  setState(() {
                                                                    pressed =
                                                                        false;
                                                                  });
                                                                });
                                                              },
                                                              child:
                                                                  AnimatedContainer(
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            250),
                                                                width: 50,
                                                                height: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: const Color(
                                                                      0xFFEFF0F3),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  boxShadow:
                                                                      pressed
                                                                          ? []
                                                                          : [
                                                                              const BoxShadow(
                                                                                color: Colors.white,
                                                                                blurRadius: 30,
                                                                                offset: Offset(-20, -10),
                                                                              ),
                                                                              const BoxShadow(
                                                                                color: Color(0xFFA3B1C6),
                                                                                blurRadius: 30,
                                                                                offset: Offset(20, 20),
                                                                              ),
                                                                            ],
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Image(
                                                                    image:
                                                                        github,
                                                                    width: 32,
                                                                    height: 32,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: IconButton(
                                        onPressed: () {
                                          showInfoDialog(context);
                                        },
                                        icon: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Lottie.asset(
                                            'assets/33321-cute-owl.json',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Material(
                                  child: IconButton(
                                    tooltip: "Sign Out",
                                    onPressed: () async {
                                      loggedIn = false;
                                      if (guestMode) {
                                        await Authentication.signOut(
                                            context: context);
                                      }
                                      await prefs?.setBool('logged-in', false);
                                      await prefs?.setBool('guest-mode', false);
                                      guestMode = false;
                                      mainViewKey.currentState?.rebuild();
                                    },
                                    icon: Icon(
                                      Icons.logout,
                                      color: Colors.grey.shade700,
                                    ),
                                    iconSize: 20,
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
                                  fontSize: 16,
                                ),
                              ),
                              if (!guestMode)
                                const Text(
                                  ", Parul",
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
                if (arts.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 40,
                            spreadRadius: 40,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TopPanel(key: topPanelKey),
                      ),
                    ),
                  ),
                if (arts.isEmpty) TopPanel(key: topPanelKey),
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
