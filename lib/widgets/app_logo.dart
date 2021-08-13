import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  // Variable
  final double? width;
  final double? height;

  AppLogo({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/logo.png",
        width: width ?? 120,
        height: height ?? 120,
        fit: BoxFit.cover,
      ),
    );
  }
}
