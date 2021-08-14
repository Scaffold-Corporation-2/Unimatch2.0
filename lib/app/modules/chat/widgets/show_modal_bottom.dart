import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              color: Colors.pinkAccent.shade100,
              padding: EdgeInsets.symmetric(vertical: 25),
              child: Text("Toque para remover",
                textAlign: TextAlign.center,
                style:  GoogleFonts.eczar(
                  height: 1.3,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),),
            ),
          ),
        );
      },
    );
  }
}