import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String hintText;
  final String labelText;
  final String prefix;
  final String suffix;
  final Color fillColor;
  final Color enableColor;
  final Color? shadowColor;
  final TextInputType keyboardType;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? suffixStyle;
  final bool obscure;
  final bool autofocus;
  final IconData? icon;
  final GestureDetector? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final bool hasFocus;
  final Function onTap;

  CustomInput({
    required this.controller,
    this.hint = "",
    this.fillColor = Colors.transparent,
    this.shadowColor,
    this.enableColor = const Color(0xff1a1919),
    this.hintText = "",
    this.obscure = false,
    this.autofocus = false,
    this.inputFormatters,
    this.hintStyle,
    this.suffixStyle,
    this.labelStyle,
    this.onChanged,
    this.prefix = "",
    this.suffix = "",
    this.labelText = "",
    this.icon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    required this.hasFocus,
    required this.onTap,
  });

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(18),
      elevation: 5.0,
      shadowColor: widget.shadowColor, // Colors.grey[350]
      child: TextFormField(
        onTap: () {
          setState(() => widget.onTap());
        },
        controller: widget.controller,
        obscureText: widget.obscure,
        autofocus: widget.autofocus,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        style: TextStyle(fontSize: 20, color: Colors.grey[900]),
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              widget.icon,
              color: Colors.grey[700],
            ),
          ),
          suffixIcon: widget.suffixIcon,
          contentPadding: widget.suffixIcon == null
              ? EdgeInsets.fromLTRB(18, 18, 12, 18)
              : EdgeInsets.fromLTRB(0, 18, 0, 18),
          labelStyle: widget.labelStyle,
          labelText: widget.hasFocus ? '' : widget.labelText,
          hintStyle: widget.hintStyle,
          hintText: widget.hintText,
          prefixText: widget.prefix,
          suffixText: widget.suffix,
          suffixStyle: widget.suffixStyle,
          filled: true,
          fillColor: widget.fillColor,
          alignLabelWithHint: true,
          //CAE0E0
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            borderSide: BorderSide(
              width: 1.18,
              color: Color(0xff1a1919),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            borderSide: BorderSide(
              width: 1.2,
              color: widget.enableColor,
            ), //Color(0xff1a1919)
          ),
        ),
        cursorColor: Colors.grey[700],
      ),
    );
  }
}
