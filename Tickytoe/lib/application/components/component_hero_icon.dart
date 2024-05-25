import 'package:flutter/material.dart';
import 'package:tikytoe/application/constants/const_colors.dart';
import 'package:tikytoe/application/constants/const_text_sizes.dart';

class ComponentHeroIcon extends StatelessWidget {
  const ComponentHeroIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Hero(
      tag: "Icon",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: Image.asset("assets/icon.png"),
          ),
          const SizedBox(height: defaultSpaceHeight),
          const Text("Tic Tac Toe", style: TextStyle(fontSize: heading)),
          const SizedBox(height: defaultSpaceHeight*3),
        ],
      ),
    );
  }
}
