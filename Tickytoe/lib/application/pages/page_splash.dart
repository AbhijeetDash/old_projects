import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tikytoe/application/components/component_hero_icon.dart';
import 'package:tikytoe/application/components/component_menu_button.dart';
import 'package:tikytoe/application/constants/const_colors.dart';
import 'package:tikytoe/application/constants/const_text_sizes.dart';
import 'package:tikytoe/application/pages/page_game.dart';
import 'package:tikytoe/application/pages/page_pick_move.dart';

class PageSplash extends StatefulWidget {
  const PageSplash({Key? key}) : super(key: key);

  @override
  State<PageSplash> createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SizedBox(
          width: _size.width,
          height: _size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ComponentHeroIcon(),
              const Text(
                "Choose your game mode",
                style: TextStyle(
                    fontSize: subheading,
                    color: textColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30.0),
              ComponentMenuButton(
                onPressed: () {
                  Get.offAll(() => const PagePickMove(),
                    curve: Curves.ease,
                    duration: const Duration(milliseconds: 600),
                    transition: Transition.rightToLeft,
                  );
                },
                title: "AI",
              ),
              const SizedBox(height: 30.0),
              ComponentMenuButton(
                onPressed: () {
                  Get.snackbar("Feature unavailable",
                      "We are working hard to get this feature.");
                },
                title: "With a friend",
                fillColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
