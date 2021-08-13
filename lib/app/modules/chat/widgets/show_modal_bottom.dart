import 'package:flutter/material.dart';

class ShowModalBottom {
  static show({
    required BuildContext context,
    required Function ontap,
  })  {


    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: GestureDetector(
            onTap: (){
              ontap();
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: Text("Toque para remover",
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 20,
              ),),
            ),
          ),
        );
      },
    );
  }
}