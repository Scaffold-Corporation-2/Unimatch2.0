import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGenericTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final double fontSize;
  final Color fillColor;
  final Color borderColor;
  final Color fontColor;
  final TextInputType type;
  final Function validation;

  CustomGenericTextFormField(
      {Key key,
      this.controller,
      this.labelText,
      this.fontSize = 3,
      this.borderColor,
      this.fontColor,
      this.fillColor,
      this.type,
      this.validation,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      textAlign: TextAlign.start,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => validation(value),
      style: GoogleFonts.rhodiumLibre(
        color: fontColor,
        fontSize: fontSize,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.rhodiumLibre(
          color: fontColor,
          fontSize: fontSize - 2,
        ),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}
