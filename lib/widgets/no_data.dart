import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:uni_match/widgets/svg_icon.dart';

class NoData extends StatelessWidget {
  // Variables
  final String? svgName;
  final Widget? icon;
  final String text;
  final bool? animated;

  const NoData(
      {this.svgName, this.icon, required this.text, this.animated = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Show icon
          Animator<double>(
              duration: Duration(milliseconds: 1000),
              cycles: 0,
              curve: Curves.easeInOut,
              tween: Tween<double>(begin: 20.0, end: 22.0),
              builder: (context, animatorState, child) =>
              animated!
                  ? svgName != null
                      ? SvgIcon("assets/icons/$svgName.svg",
                          width: animatorState.value * 6,
                          height: animatorState.value * 6,
                          color: Theme.of(context).primaryColor)
                      : icon!
                  : svgName != null
                      ? SvgIcon("assets/icons/$svgName.svg", width: 100, height: 100,
                          color: Theme.of(context).primaryColor)
                      : icon!),
          Text(text,
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
