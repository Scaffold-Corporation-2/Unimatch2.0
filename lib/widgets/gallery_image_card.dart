import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/dialogs/common_dialogs.dart';
import 'package:uni_match/dialogs/progress_dialog.dart';
import 'package:uni_match/dialogs/vip_dialog.dart';
import 'package:uni_match/widgets/default_card_border.dart';
import 'package:uni_match/widgets/image_source_sheet.dart';

class GalleryImageCard extends StatelessWidget {
  // Variables
  final ImageProvider imageProvider;
  final String? imageUrl;
  final BoxFit boxFit;
  final int index;

  const GalleryImageCard({
    required this.imageProvider,
    required this.imageUrl,
    required this.boxFit,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            shape: defaultCardBorder(),
            color: Colors.grey[300],
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(fit: boxFit, image: imageProvider),
                  color: Colors.grey.withAlpha(70),
                ),
              ),
            ),
          ),
          Positioned(
            child: IconButton(
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(imageUrl == null ? Icons.add : Icons.close,
                      color: Colors.white),
                ),
                onPressed: () {
                  /// Check image url to exe action
                  if (imageUrl == null) {
                    /// Add or update image
                    _selectImage(context);
                  } else {
                    /// Delete image from gallery
                    _deleteGalleryImage(context);
                  }
                }),
            right: 8,
            bottom: 5,
          )
        ],
      ),
      onTap: () {
        /// Add or update image
        _selectImage(context);
      },
    );
  }

  /// Get image from camera / gallery
  void _selectImage(BuildContext context) async {
    /// Initialization
    final AppController i18n = Modular.get();
    final pr = ProgressDialog(context, isDismissible: false);

    /// Check user vip account
    if (!UserModel().userIsVip && index > 3) {
      /// Show VIP dialog
      showDialog(context: context, builder: (context) => VipDialog());
      debugPrint('You need to activate vip account');
      return;
    }

    await showModalBottomSheet(
        context: context,
        builder: (context) => ImageSourceSheet(
              onImageSelected: (image) async {
                if (image != null) {
                  print(image);

                  /// Show progress dialog
                  pr.show(i18n.translate("processing")!);

                  /// Update gallery image
                  await UserModel()
                      .updateProfileImage(
                          imageFile: image,
                          oldImageUrl: imageUrl,
                          path: 'gallery',
                          index: index)
                      .whenComplete(() {
                    Timer(Duration(milliseconds: 200), () {
                      Modular.to.popAndPushNamed('/profile/edit');
                      pr.hide();
                    });
                  });
                }
              },
            ));
  }

  /// Delete image from gallery
  void _deleteGalleryImage(BuildContext context) async {
    /// Initialization
    final AppController i18n = Modular.get();
    final pr = ProgressDialog(context, isDismissible: false);

    /// Check user vip account
    if (!UserModel().userIsVip && index > 3) {
      /// Show VIP dialog
      showDialog(context: context, builder: (context) => VipDialog());
      debugPrint('You need to activate vip account');
      return;
    }

    /// Confirm before
    confirmDialog(context,
        message: i18n.translate("photo_will_be_deleted")!,
        negativeAction: () => Navigator.of(context).pop(),
        positiveText: i18n.translate("DELETE"),
        positiveAction: () async {
          // Show processing dialog
          pr.show(i18n.translate("processing")!);

          /// Delete image
          await UserModel()
              .deleteGalleryImage(imageUrl: imageUrl!, index: index).whenComplete(() {
            Timer(Duration(milliseconds: 200), () {
              Modular.to.popAndPushNamed('/profile/edit');
              pr.hide();
            });
          });
        });
  }
}
