
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikytoe/application/pages/page_splash.dart';

class AppMaterialController extends StatefulWidget {
  const AppMaterialController({Key? key}) : super(key: key);

  @override
  State<AppMaterialController> createState() => _AppMaterialControllerState();
}

class _AppMaterialControllerState extends State<AppMaterialController> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        brightness: Brightness.light
      ),
      debugShowCheckedModeBanner: false,
      home: const PageSplash(),
    );
  }
}
