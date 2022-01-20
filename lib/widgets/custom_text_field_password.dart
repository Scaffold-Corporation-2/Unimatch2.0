import 'package:flutter/material.dart';

class CustomTextFieldPassword extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final bool? visualizar;
  final bool password;
  final Function? onTapPassword;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController controller;

  const CustomTextFieldPassword(
      {Key? key,
        required this.hintText,
        required this.icon,
        required this.textInputType,
        required this.controller,
        this.password = false,
        this.obscureText = false,
        this.visualizar,
        this.onTapPassword,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      style: TextStyle(fontSize: 18, color: Colors.grey[900]),
      textAlign: TextAlign.start,
      cursorColor: Colors.grey[700],
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.grey[700]),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        alignLabelWithHint: true,
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: icon,
        ),
        suffixIcon: password ? GestureDetector(
          onTap: (){
            onTapPassword!();
          },
          child: Icon(
            visualizar! ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey[700],
          ),
        ): null,
        contentPadding:EdgeInsets.fromLTRB(0, 18, 0, 18),
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
