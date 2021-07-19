import 'package:brasil_fields/brasil_fields.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/modules/login/store/login_store.dart';
import 'package:uni_match/widgets/default_button.dart';
import 'package:uni_match/widgets/svg_icon.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends ModularState<PhoneNumberScreen, LoginStore> {

  @override
  void initState() {
    controller.addForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.progress(context);

    return Observer(
      builder:(_) =>  Scaffold(
          key: controller.scaffoldKey,
          appBar: AppBar(
            title: Text(controller.i18n.translate("phone_number")!),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: SvgIcon("assets/icons/call_icon.svg",
                      width: 60, height: 60, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(controller.i18n.translate("sign_in_with_phone_number")!,
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                SizedBox(height: 25),
                Text(
                    controller.i18n.translate(
                        "please_enter_your_phone_number_and_we_will_send_you_a_sms")!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
                SizedBox(height: 22),

                /// Form
                Observer(
                  builder:(_) =>  Form(
                    key: controller.formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            controller: controller.numberController,
                            decoration: InputDecoration(
                                labelText: controller.i18n.translate("phone_number"),
                                hintText: controller.i18n.translate("enter_your_number"),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: CountryCodePicker(
                                      alignLeft: false,
                                      initialSelection: controller.initialSelection,
                                      onChanged: (country) {
                                        /// Get country code
                                        controller.phoneCode = country.dialCode!;
                                      }),
                                )),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              // FilteringTextInputFormatter.allow(new RegExp("[0-9]"))
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter()
                            ],
                            validator: (number) {
                              // Basic validation
                              if (number == null) {
                                return controller.i18n
                                    .translate("please_enter_your_phone_number");
                              }
                              return null;
                            },
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.maxFinite,
                          child: DefaultButton(
                            child: Text(controller.i18n.translate("CONTINUE")!,
                                style: TextStyle(fontSize: 18)),
                            onPressed: () async {
                              /// Validate form
                              if (controller.formKey!.currentState!.validate()) {
                                /// Sign in
                                controller.signIn(context, mounted);
                              }
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
    );
  }
}
