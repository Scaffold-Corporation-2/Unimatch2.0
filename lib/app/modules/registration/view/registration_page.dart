import 'package:animate_do/animate_do.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_match/app/modules/registration/store/registration_store.dart';
import 'package:uni_match/app/modules/registration/view/widgets/registration_text_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState
    extends ModularState<RegistrationPage, RegistrationStore> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurpleAccent,
                Colors.purpleAccent,
                Colors.pinkAccent,
                Colors.pink,
              ],
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin: const EdgeInsets.only(top: 5.0, left: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(8)),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back, color: Colors.white70,)
                            )
                        ),
                      ),
                      Text(
                        "Pré Cadastro",
                        style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: const Radius.circular(40.0),
                                    topLeft: const Radius.circular(40.0),
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 25.0,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Pessoal",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      maxLines: 3,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 45,
                              color: Colors.white60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.school,
                                    size: 20.0,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: const Radius.circular(40.0),
                                    topRight: const Radius.circular(40.0),
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.description,
                                    size: 20.0,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: RegistrationTextField(
                              hintText: "Nome",
                              textInputType: TextInputType.text,
                              controller: controller.nameController,
                            ),
                          ),
                          SizedBox(height: 15,),

                          RegistrationTextField(
                            hintText: "E-mail",
                            textInputType: TextInputType.text,
                            controller: controller.emailController,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RegistrationTextField(
                            hintText: "Instagram",
                            textInputType: TextInputType.text,
                            controller: controller.instaController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Column(
                    children: [
                      controller.nameController.text.isNotEmpty &&
                              controller.emailController.text.isNotEmpty&&
                              controller.instaController.text.isNotEmpty
                          ? FadeInDown(
                        delay: Duration(milliseconds: 200),
                            child: TextButton(
                                child: Text(
                                  "Prosseguir",
                                  style: GoogleFonts.nunito(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (controller.nameController.text.isEmpty ||
                                      controller.emailController.text.isEmpty ||
                                      controller.instaController.text.isEmpty)
                                    Fluttertoast.showToast(msg: 'Preencha todos os campos!');
                                  else {
                                    if(controller.nameController.text.length > 3){
                                      if(EmailValidator.validate(controller.emailController.text)){
                                        Modular.to.pushNamed("/registration/registration2", arguments: controller);
                                      }else{
                                        Fluttertoast.showToast(msg: 'E-mail inserido não é válido!');
                                      }
                                    }else{
                                      Fluttertoast.showToast(msg: 'Seu nome deve conter mais de 3 caracteres!');
                                    }
                                  }
                                },
                              ),
                          )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
