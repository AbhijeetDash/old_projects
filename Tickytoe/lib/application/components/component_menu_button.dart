import 'package:flutter/material.dart';
import 'package:tikytoe/application/constants/const_colors.dart';

class ComponentMenuButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String title;
  Color? fillColor;
  ComponentMenuButton(
      {Key? key, required this.onPressed, required this.title, this.fillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: const StadiumBorder(),
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          gradient: fillColor == null
              ? const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [gradientPurple, gradientBlue],
                )
              : LinearGradient(
                  colors: [fillColor!, fillColor!],
                ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 10.0,
              color: Colors.black38,
            )
          ],
        ),
        child: SizedBox(
          width: 150,
          height: 40,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: fillColor == null ? Colors.white : textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
