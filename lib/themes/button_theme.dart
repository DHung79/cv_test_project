import 'package:flutter/material.dart';

class JTButton {
  static rounded({
    required void Function()? onPressed,
    required Widget child,
    Color color = Colors.blue,
    Color? splashColor,
    double width = 150,
    double height = 50,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: width,
        maxHeight: height,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: splashColor,
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
