import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/widgets/svg_icon.dart';

class ImageSourceSheet extends StatelessWidget {
  // Constructor
  ImageSourceSheet({required this.onImageSelected});

  // Callback function to return image file
  final Function(File?) onImageSelected;
  // ImagePicker instance
  final picker = ImagePicker();
  final AppController i18n = Modular.get();

  Future<void> selectedImage(BuildContext context, File? image) async {

    // Check file
    if (image != null) {
      final croppedImage = await ImageCropper.cropImage(
          sourcePath: image.path,
          cropStyle: CropStyle.circle,
          aspectRatioPresets: [CropAspectRatioPreset.square,],
          maxWidth: 400,
          maxHeight: 400,
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: i18n.translate("edit_crop_image"),
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: Theme.of(context).primaryColor,
          ));
      onImageSelected(croppedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        builder: ((context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                /// Select image from gallery
                TextButton.icon(
                  icon: Icon(Icons.photo_library, color: Colors.grey, size: 27),
                  label: Text(i18n.translate("gallery")!,
                      style: TextStyle(fontSize: 16, color: Theme.of(context).iconTheme.color)),
                  onPressed: () async {
                    // Get image from device gallery
                    // ignore: deprecated_member_use
                    final pickedFile = await picker.getImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile == null) return;
                    selectedImage(context, File(pickedFile.path));
                  },
                ),

                /// Capture image from camera
                TextButton.icon(
                  icon: SvgIcon("assets/icons/camera_icon.svg",
                      width: 20, height: 20),
                  label: Text(i18n.translate("camera")!,
                      style: TextStyle(fontSize: 16, color: Theme.of(context).iconTheme.color)),
                  onPressed: () async {
                    // Capture image from camera
                    // ignore: deprecated_member_use
                    final pickedFile = await picker.getImage(
                      source: ImageSource.camera,
                    );
                    if (pickedFile == null) return;
                    selectedImage(context, File(pickedFile.path));
                  },
                ),
              ],
            )));
  }
}
