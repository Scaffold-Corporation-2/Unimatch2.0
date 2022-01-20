import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationTextField extends StatelessWidget {
  final String hintText;
  final bool password;
  final Function? onTapPassword;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final List<TextInputFormatter>? textInputFormatter;

  const RegistrationTextField(
      {Key? key,
        required this.hintText,
        required this.textInputType,
        required this.controller,
        this.password = false,
        this.obscureText = false,
        this.onTapPassword,
        this.textInputFormatter,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.nunito(
        color: Colors.grey[700],
        fontSize: 17,
      ),
      keyboardType: textInputType,
      inputFormatters: textInputFormatter,
      cursorColor: Colors.white,
      controller: controller,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.grey[700]),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.6),
        alignLabelWithHint: true,
        contentPadding:EdgeInsets.fromLTRB(20, 18, 20, 18),
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
            color: Colors.white,
          ), //Color(0xff1a1919)
        ),
      ),
    );
  }
}
