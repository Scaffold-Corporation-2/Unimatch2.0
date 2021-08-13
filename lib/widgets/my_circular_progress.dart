import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyCircularProgress extends StatelessWidget {
  final double size;

  const MyCircularProgress({Key? key, this.size = 50}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPumpingHeart(
        color: Theme.of(context).primaryColor,
        size: size,
      ),
    );
  }
}
