import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_match/app/modules/login/store/login_store.dart';
import 'package:uni_match/widgets/default_button.dart';
import 'package:uni_match/widgets/my_circular_progress.dart';
import 'package:uni_match/widgets/svg_icon.dart';
import 'package:uni_match/widgets/terms_of_service_row.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ModularState<SignUpScreen, LoginStore> {


  @override
  void initState() {
    controller.addForm();
    controller.getUniversities();
    controller.nameBirthday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Observer(
        builder:(_) => Scaffold(
            key: controller.scaffoldKey,
            body: controller.isLoading
            ? MyCircularProgress(size: 60,)
            : SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(controller.i18n.translate("create_account")!,
                      style: GoogleFonts.nunito(fontSize: 25, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),

                  /// Profile photo
                  Observer(
                    builder:(_) =>  GestureDetector(
                      child: Center(
                          child: controller.imageFile == null
                              ? CircleAvatar(
                                radius: 60,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: SvgIcon("assets/icons/camera_icon.svg",
                                width: 40, height: 40, color: Colors.white),
                          )
                              : CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(controller.imageFile!),
                          )),
                      onTap: () {
                        /// Get profile image
                        FocusScope.of(context).unfocus();
                        controller.getImage(context);
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(controller.i18n.translate("profile_photo")!,
                      textAlign: TextAlign.center),

                  SizedBox(height: 22),

                  /// Form
                  Observer(
                    builder:(_) =>  Form(
                      key: controller.formKey,
                      child: Column(
                        children: <Widget>[
                          /// FullName field
                          TextFormField(
                            controller: controller.nameController,
                            cursorColor: Colors.grey[700],
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(28)),
                                  borderSide: BorderSide(width: 1.8,color: Theme.of(context).primaryColor,),
                                ),
                                labelText: controller.i18n.translate("fullname"),
                                hintText: controller.i18n.translate("enter_your_fullname"),
                                labelStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgIcon("assets/icons/user_icon.svg"),
                                )
                            ),
                            validator: (name) {
                              // Basic validation
                              if (name?.isEmpty ?? false) {
                                return controller.i18n.translate("please_enter_your_fullname");
                              }
                              return null;
                            },
                            onTap: () => FocusScope.of(context).unfocus(),
                          ),
                          SizedBox(height: 20),

                          /// User gender
                          DropdownButtonFormField<String>(
                            items: controller.genders.map((gender) {
                              return new DropdownMenuItem(
                                value: gender,
                                child: controller.i18n.translate("lang") != 'pt_br'
                                    ? Text(
                                    '${gender.toString()} - ${controller.i18n.translate(gender.toString().toLowerCase())}')
                                    : Text(gender.toString()),
                              );
                            }).toList(),
                            hint: Text(controller.i18n.translate("select_gender")!),
                            onChanged: (gender) {
                              controller.selecionarGenero(gender!);
                            },
                            validator: (String? value) {
                              if (value == null) {
                                return controller.i18n.translate("please_select_your_gender");
                              }
                              return null;
                            },
                            onTap: () => FocusScope.of(context).unfocus(),
                          ),
                          SizedBox(height: 20),


                          /// User gender
                          DropdownButtonFormField<String>(
                            items: controller.sexualOrientation.map((orientation) {
                              return new DropdownMenuItem(
                                value: orientation,
                                child: controller.i18n.translate("lang") != 'pt_br'
                                    ? Text(
                                    '${orientation.toString()} - ${controller.i18n.translate(orientation.toString().toLowerCase())}')
                                    : Text(orientation.toString()),
                              );
                            }).toList(),
                            hint: Text(controller.i18n.translate("select_orientation")!),
                            onChanged: (orientation) {
                              controller.selecionarOrientacao(orientation!);
                            },
                            validator: (String? value) {
                              if (value == null) {
                                return controller.i18n.translate("please_select_your_orientation");
                              }
                              return null;
                            },
                            onTap: () => FocusScope.of(context).unfocus(),
                          ),
                          SizedBox(height: 20),
                          /// School field
                          GestureDetector(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                var response = await Modular.to.pushNamed('/login/university');
                                if(response != null)
                                  controller.selectedUniversity(response as String);
                              },
                              child: Observer(
                                builder:(_) =>  Material(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(color: Colors.grey[500]!)
                                  ),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: controller.schoolController,
                                    textCapitalization: TextCapitalization.characters,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(28)),
                                          borderSide: BorderSide(width: 1.8,color: Theme.of(context).primaryColor,),
                                        ),
                                        labelStyle: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 18
                                        ),
                                        enabled: false,
                                        hintText:  controller.i18n.translate("enter_your_school_name"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: SvgIcon("assets/icons/university_icon.svg"),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                          ),
                          SizedBox(height: 20),

                          /// Birthday card
                          Observer(
                            builder:(_) => Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    side: BorderSide(color: Colors.grey[350] as Color)),
                                child: ListTile(
                                  leading: SvgIcon("assets/icons/calendar_icon.svg"),
                                  title: Text(controller.birthday!,
                                      style: TextStyle(color: Colors.grey)),
                                  trailing: Icon(Icons.arrow_drop_down),
                                  onTap: () {
                                    /// Select birthday,
                                    controller.showDatePicker(context);
                                  },
                                )),
                          ),
                          SizedBox(height: 20),

                          /// Bio field
                          TextFormField(
                            controller: controller.bioController,
                            maxLines: 4,
                            cursorColor: Colors.grey[700],
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(28)),
                                borderSide: BorderSide(width: 1.8,color: Theme.of(context).primaryColor,),
                              ),
                              labelStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18
                              ),
                              labelText: controller.i18n.translate("bio"),
                              hintText: controller.i18n.translate("please_write_your_bio"),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgIcon("assets/icons/info_icon.svg"),
                              ),
                            ),
                            validator: (bio) {
                              if (bio?.isEmpty ?? false) {
                                return controller.i18n.translate("please_write_your_bio");
                              }
                              return null;
                            },
                            onTap: () => FocusScope.of(context).unfocus(),
                          ),

                          /// Aceitar Termos
                          SizedBox(height: 5),
                          _agreePrivacy(),
                          SizedBox(height: 20),

                          SizedBox(
                            width: double.maxFinite,
                            child: DefaultButton(
                              child: Text(controller.i18n.translate("CREATE_ACCOUNT")!,
                                  style: TextStyle(fontSize: 18)),
                              onPressed: () {
                                /// Cadastrar
                                FocusScope.of(context).unfocus();
                                controller.createAccount(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
  /// Handle Agree privacy policy
  Widget _agreePrivacy() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Checkbox(
              activeColor: Theme.of(context).primaryColor,
              value: controller.agreeTerms,
              onChanged: (value) {
                controller.setAgreeTerms(value!);
              }),
          Row(
            children: <Widget>[
              GestureDetector(
                  onTap: () => controller.setAgreeTerms(controller.agreeTerms),
                  child: Text(controller.i18n.translate("i_agree_with")!,
                      style: TextStyle(fontSize: 16))),
              // Terms of Service and Privacy Policy
              TermsOfServiceRow(color: Colors.black),
            ],
          ),
        ],
      ),
    );
  }
}
