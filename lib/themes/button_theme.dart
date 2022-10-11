import 'package:flutter/material.dart';

class JTButton {
  static Widget rounded({
    required void Function()? onPressed,
    required Widget child,
    Color color = Colors.blue,
    Color? splashColor,
    double width = 150,
    double height = 50,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: border ?? Border.all(color: Colors.black),
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
      constraints: BoxConstraints(
        maxWidth: width,
        maxHeight: height,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: splashColor,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
