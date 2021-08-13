import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGenericTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final double textFontSize;
  final double captionFontSize;
  final Color fillColor;
  final Color borderColor;
  final Color fontColor;
  final TextInputType type;
  final Function validation;

  CustomGenericTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.textFontSize = 15,
    this.captionFontSize = 15,
    required this.borderColor,
    required this.fontColor,
    required this.fillColor,
    required this.type,
    required this.validation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      textAlign: TextAlign.start,
      controller: controller,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => validation(value),
      style: GoogleFonts.rhodiumLibre(
        color: fontColor,
        fontSize: textFontSize,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.eczar(
          color: fontColor,
          fontSize: captionFontSize,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}
