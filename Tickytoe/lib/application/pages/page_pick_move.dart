import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tikytoe/application/components/component_menu_button.dart';
import 'package:tikytoe/application/constants/const_colors.dart';
import 'package:tikytoe/application/constants/const_text_sizes.dart';
import 'package:tikytoe/application/pages/page_game.dart';
import 'package:tikytoe/application/pages/page_splash.dart';

class PagePickMove extends StatefulWidget {
  const PagePickMove({Key? key}) : super(key: key);

  @override
  State<PagePickMove> createState() => _PagePickMoveState();
}

class _PagePickMoveState extends State<PagePickMove> {
  String defaultSelection = "x";
  late Size _size;

  void _navigateToGameBoard(){
    Get.offAll(
          () => PageGame(userMove: defaultSelection),
      curve: Curves.ease,
      duration: const Duration(milliseconds: 600),
      transition: Transition.rightToLeft,
    );
  }

  void _makeMoveSelection(String? value){
    setState(() {
      defaultSelection = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Get.offAll(
                () => const PageSplash(),
                curve: Curves.ease,
                duration: const Duration(milliseconds: 600),
                transition: Transition.leftToRight,
              );
            },
            icon: const Icon(Icons.arrow_back_ios, color: textColor),
          ),
        ),
        body: SizedBox(
          width: _size.width,
          height: _size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100.0),
              const Text(
                "Pick your move",
                style: TextStyle(
                    fontSize: subheading,
                    color: textColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Tap to select",
                style: TextStyle(fontSize: 12, color: textColor),
              ),
              const SizedBox(height: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    splashColor: Colors.transparent,
                    onTap: () {
                      _makeMoveSelection("x");
                    },
                    child:
                        Image.asset("assets/x.png", width: _size.width * 0.3),
                  ),
                  const SizedBox(width: 20.0),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    splashColor: Colors.transparent,
                    onTap: () {
                      _makeMoveSelection("o");
                    },
                    child:
                    Image.asset("assets/o.png", width: _size.width * 0.3),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Radio(
                      value: "x",
                      groupValue: defaultSelection,
                      onChanged: _makeMoveSelection
                    ),
                    Radio(
                      value: "o",
                      groupValue: defaultSelection,
                      onChanged: _makeMoveSelection
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              const Spacer(),
              ComponentMenuButton(onPressed: (){
                _navigateToGameBoard();
              }, title: "Play"),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
