import 'package:curly_create/io/app_data_manager.dart';
import 'package:curly_create/main.dart';
import 'package:curly_create/ui/sign_in_screen/sign_in_screen.dart';
import 'package:curly_create/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.bottomCenter,
                child: LottieController(
                  name: '76879-waves-colors.json',
                  duration: Duration(milliseconds: 4000),
                  delay: Duration(milliseconds: 1000),
                  size: 300,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Logo(scale: 1.5),
                    const Text(
                      "version $version-stable",
                      style: TextStyle(
                        fontFamily: "Itim",
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 80),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/76734-shield-icon.json',
                              width: 200),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInScreen()));
                            },
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Colors.blueAccent.withOpacity(0.1),
                            ),
                            child: const Text(
                              "Master Login",
                              style: TextStyle(
                                fontFamily: "Itim",
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Text(
                            "Full Control Mode",
                            style: TextStyle(
                              fontFamily: "Itim",
                              color: Colors.grey.shade700,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Lottie.asset('assets/110283-vrrr.json', width: 80),
                    TextButton(
                      onPressed: () async {
                        guestMode = true;
                        await prefs?.setBool('guest-mode', true);
                        mainViewKey.currentState?.rebuild();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.greenAccent.withOpacity(0.2),
                      ),
                      child: const Text(
                        "Try Guest Mode",
                        style: TextStyle(
                          fontFamily: "Itim",
                          color: Colors.green,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LottieController extends StatefulWidget {
  final String name;
  final double size;
  final Duration duration;
  final Duration? delay;

  const LottieController(
      {super.key,
      required this.name,
      required this.duration,
      required this.size,
      this.delay});

  @override
  State<LottieController> createState() => _LottieControllerState();
}

class _LottieControllerState extends State<LottieController>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/${widget.name}',
      width: widget.size,
      controller: _animationController,
      onLoaded: (composition) async {
        if (widget.delay != null) {
          await Future.delayed(widget.delay as Duration);
        }
        if(mounted) {
          _animationController.forward();
        }
      },
    );
  }
}
