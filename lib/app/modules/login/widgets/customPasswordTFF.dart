import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_match/widgets/customIcons_shared.dart';

class CustomPasswordTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final double fontSize;
  final double captionFontSize;
  final Color iconColor;
  final Color fillColor;
  final Color borderColor;
  final Color fontColor;
  final Function validation;

  CustomPasswordTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.fontSize = 15,
    this.captionFontSize = 15,
    required this.borderColor,
    required this.fontColor,
    required this.fillColor,
    required this.validation,
    required this.iconColor,
  }) : super(key: key);

  @override
  _CustomPasswordTextFormFieldState createState() =>
      _CustomPasswordTextFormFieldState();
}

class _CustomPasswordTextFormFieldState
    extends State<CustomPasswordTextFormField> {
  bool hidePassword = true;
  Icon passwordIcon = Icon(Icons.remove_red_eye_outlined, color: Colors.black);

  void showPass() {
    if (hidePassword == true) {
      hidePassword = false;
      passwordIcon = Icon(
        CustomIcons.eye,
        color: widget.iconColor,
        size: 18,
      );
    } else if (hidePassword == false) {
      hidePassword = true;
      passwordIcon = Icon(
        CustomIcons.eye_off,
        color: widget.iconColor,
        size: 18,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      textAlign: TextAlign.start,
      controller: widget.controller,
      obscureText: hidePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => widget.validation(value),
      style: GoogleFonts.rhodiumLibre(
          color: widget.fontColor, fontSize: widget.fontSize),
      decoration: InputDecoration(
        // ignore: deprecated_member_use
        suffix: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Icon(
                  passwordIcon.icon,
                  color: widget.iconColor,
                ),
                onTap: () {
                  setState(() {
                    showPass();
                  });
                },
              ),
            ],
          ),
        ),
        labelText: widget.labelText,
        labelStyle: GoogleFonts.rhodiumLibre(
          color: widget.fontColor,
          fontSize: widget.captionFontSize,
        ),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: widget.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: widget.borderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: widget.borderColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: widget.borderColor),
        ),
      ),
    );
  }
}
