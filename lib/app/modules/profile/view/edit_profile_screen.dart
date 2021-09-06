import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/app/modules/profile/store/profile_store.dart';
import 'package:uni_match/app/modules/profile/view/profile_screen.dart';
import 'package:uni_match/dialogs/common_dialogs.dart';
import 'package:uni_match/dialogs/progress_dialog.dart';
import 'package:uni_match/widgets/image_source_sheet.dart';
import 'package:uni_match/widgets/svg_icon.dart';
import 'package:uni_match/widgets/user_gallery.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ModularState<EditProfileScreen, ProfileStore> {
  // Variables
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _schoolController =
      TextEditingController(text: UserModel().user.userSchool);


  final String _orientation = UserModel().user.userOrientation;

  final _bioController = TextEditingController(text: UserModel().user.userBio);
  AppController _i18n = Modular.get();
  late ProgressDialog _pr;

  File? imagemSelecionada;

  @override
  Widget build(BuildContext context) {
    /// Initialization
    _pr = ProgressDialog(context, isDismissible: false);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_i18n.translate("edit_profile")!),
        actions: [
          // Save changes button
          TextButton(
            child: Text(_i18n.translate("SAVE")!,
            style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: () {
              /// Validate form
              if (_formKey.currentState!.validate()) {
                setState(() => _saveChanges());
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile photo
              GestureDetector(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: imagemSelecionada == null?
                          NetworkImage(UserModel().user.userProfilePhoto)
                          : FileImage(imagemSelecionada!) as ImageProvider,
                        radius: 80,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),

                      /// Edit icon
                      Positioned(
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                        right: 0,
                        bottom: 0,
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  /// Update profile image
                  _selectImage(
                      context: context,
                      imageUrl: UserModel().user.userProfilePhoto,
                      path: 'profile');
                },
              ),
              SizedBox(height: 10),
              Center(
                child: Text(_i18n.translate("profile_photo")!,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center),
              ),

              /// Profile gallery
              Text(_i18n.translate("gallery")!,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.left),
              SizedBox(height: 5),

              /// Show gallery
              UserGallery(),

              SizedBox(height: 20),
              /// Bio field
              TextFormField(
                controller: _bioController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: _i18n.translate("bio"),
                  hintText: _i18n.translate("write_about_you"),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgIcon("assets/icons/info_icon.svg"),
                  ),
                ),
                validator: (bio) {
                  if (bio == null) {
                    return _i18n.translate("please_write_your_bio");
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              /// User gender
              Observer(
                builder:(_) => DropdownButtonFormField<String>(
                  items: controller.sexualOrientation.map((orientation) {
                    return new DropdownMenuItem(
                      value: orientation,
                      child: controller.i18n.translate("lang") != 'pt_br'
                          ? Text(
                          '${orientation.toString()} - ${controller.i18n.translate(orientation.toString().toLowerCase())}')
                          : Text(orientation.toString()),
                    );
                  }).toList(),
                  hint: Text(_orientation),
                  onChanged: (orientation) {
                    controller.selecionarOrientacao(orientation!);
                  },
                  validator: (String? value) {
                    if (value == null ) {
                      print(_orientation);
                      controller.selecionarOrientacao(_orientation);
                    }
                    return null;
                  },
                  onTap: () => FocusScope.of(context).unfocus(),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Get image from camera / gallery
  void _selectImage({required String imageUrl, required String path, required context}) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => ImageSourceSheet(
              onImageSelected: (image) async {
                if (image != null) {
                  if (Platform.isAndroid) {

                    _pr.show(_i18n.translate("processing")!);

                    final GoogleVisionImage visionImage = GoogleVisionImage.fromFile(image);
                    final FaceDetector faceDetector = GoogleVision.instance.faceDetector();
                    final List<Face> faces = await faceDetector.processImage(visionImage);

                    debugPrint("Faces detectadas: ${faces.length}");

                    if(faces.length == 1){

                      await UserModel().updateProfileImage(
                          imageFile: image, oldImageUrl: imageUrl, path: 'profile');

                      setState(() {
                        imagemSelecionada = image;
                      });

                      _pr.hide();
                      Navigator.of(context).pop();

                    }else if(faces.length > 1){
                      debugPrint('Varias pessoas na foto');

                      infoDialog(
                          context,
                          positiveAction: (){
                            _pr.hide();
                            Navigator.of(context).pop();
                          },
                          message: "Não utilize foto em grupo no seu perfil da Unimatch. Isso é prejudicial para você mesmo!");

                    }else{
                      debugPrint('Pessoa não identificada');

                      infoDialog(
                          context,
                          positiveAction: (){
                            _pr.hide();
                            Navigator.of(context).pop();
                          },
                          message: "Não foi possível identificar você na foto. "
                              "Se você estiver na imagem, tente novamente mais tarde ou tente adicionar outra foto,  "
                              "mas se o problema persistir, entre em contato conosco via instagram: @unimatch.app");
                    }
                    faceDetector.close();
                  }
                }
              },
            ));
  }

  /// Update profile changes for TextFormField only
  void _saveChanges() {
    /// Update uer profile
    UserModel().updateProfile(
        userSchool: _schoolController.text.trim(),
        userOrientation: controller.selectedOrientation!,
        userBio: _bioController.text.trim(),
        onSuccess: () {
          /// Show success message
          successDialog(context,
              message: _i18n.translate("profile_updated_successfully")!,
              positiveAction: () {
            /// Close dialog
            Navigator.of(context).pop();

            /// Go to profilescreen
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ProfileScreen(user: UserModel().user, showButtons: false)));
          });
        },
        onFail: (error) {
          // Debug error
          debugPrint(error);
          // Show error message
          errorDialog(context,
              message: _i18n
                  .translate("an_error_occurred_while_updating_your_profile")!);
        });
  }
}