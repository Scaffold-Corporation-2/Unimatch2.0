import 'dart:math';
import 'package:flutter/material.dart';

class DialogMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DialogMenuState();
}

class DialogMenuState extends State<DialogMenu>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;
  final double radius = 90.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    scaleAnimation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Center(
      child: ScaleTransition(
        scale: scaleAnimation!,
        child: Container(
          margin: EdgeInsets.all(20.0),
          padding: EdgeInsets.all(15.0),
          height: size * 0.7,
          width: size * 0.7,
          decoration: ShapeDecoration(
              color: Colors.grey.withOpacity(0.4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))
          ),
          child: Center(
            child: Stack(
              children: [
                Transform.translate(
                  offset: Offset(radius * cos(2 * pi/4), radius * sin(2 * pi/4)),
                  child: cardText(
                      title: "Missões",
                      image: "crow_badge"
                  ),
                ),

                Transform.translate(
                  offset: Offset(radius * cos(4 * pi/4), radius * sin(4 * pi/4)),
                  child: cardText(
                      title: "Marketplace",
                      image: "ecommerce"
                  ),
                ),

                Transform.translate(
                  offset: Offset(radius * cos(6 * pi/4), radius * sin(6 * pi/4)),
                  child: cardText(
                      title: "Study",
                      image: "study"
                  ),
                ),

                Transform.translate(
                  offset: Offset(radius * cos(8 * pi/4), radius * sin(8 * pi/4)),
                  child: cardText(
                      title: "UniStore",
                      image: "unistore"
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardText({required String title, required String image}){
    return Material(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.width * 0.18,
        width: MediaQuery.of(context).size.width * 0.22,
        child: Column(
          children: [
            Expanded(
              flex: 3,
                child: Image.asset('assets/images/$image.png',)
            ),
            Expanded(
              flex: 1,
                child: Text(title, softWrap: true, overflow: TextOverflow.ellipsis,)
            )
          ],
        ),
      ),
    );
  }
}