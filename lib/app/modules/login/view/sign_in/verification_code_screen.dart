import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/app/modules/login/store/login_store.dart';
import 'package:uni_match/dialogs/common_dialogs.dart';
import 'package:uni_match/plugins/otp_screen/otp_screen.dart';
import 'package:uni_match/widgets/svg_icon.dart';

class VerificationCodeScreen extends StatefulWidget {
  // Variables
  final String verificationId;

  // Constructor
  VerificationCodeScreen({
    required this.verificationId,
  });

  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends ModularState<VerificationCodeScreen, LoginStore> {


  @override
  Widget build(BuildContext context) {
    /// Initialization
    controller.progress(context);

    return OtpScreen.withGradientBackground(
      topColor: Theme.of(context).primaryColor,
      bottomColor: Theme.of(context).primaryColor.withOpacity(.7),
      otpLength: 6,
      validateOtp: validateOtp,
      routeCallback: (context) {},
      icon: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: SvgIcon("assets/icons/phone_icon.svg",
              width: 40, height: 40, color: Theme.of(context).primaryColor),
        ),
      title: controller.i18n.translate("verification_code")!,
      subTitle: controller.i18n.translate("please_enter_the_sms_code_sent")!,
    );
  }

  /// Navigation
  void _nextScreen(String nomeRota){
    Modular.to.navigate(nomeRota);
  }

  /// Go to enable location or GPS screen
  void goToEnableLocationOrGpsScreen(String action) {
    Modular.to.navigate('/login/signIn/phone/enable', arguments: action);
  }

  /// logic to validate otp return [null] when success else error [String]
  Future<String?> validateOtp(String otp) async {
    /// Handle entered verification code here
    controller.pr.show(controller.i18n.translate("processing")!);

    await UserModel().signInWithOTP(
        verificationId: widget.verificationId,
        otp: otp,
        checkUserAccount: () {
          /// Auth user account
          UserModel().authUserAccount(homeScreen: () {
            /// Go to home screen
            _nextScreen('/home');
          }, signUpScreen: () async {

            /// Check location permission
            await controller.checkLocationPermission(onGpsDisabled: () {
              /// Go to Enable GPS screen
              goToEnableLocationOrGpsScreen('GPS');
            }, onDenied: () {
              /// Go to enable location screen
              goToEnableLocationOrGpsScreen('location');
            }, onGranted: () {
              /// Go to sign up screen
              _nextScreen('/login/signUp');
            });
          });
        },
        onError: () async {
          // Hide dialog
          await controller.pr.hide();
          // Show error message to user
          errorDialog(context, message: controller.i18n.translate("we_were_unable_to_verify_your_number")!);
        });

    // Hide progress dialog
    await controller.pr.hide();

    return null;
  }

}
