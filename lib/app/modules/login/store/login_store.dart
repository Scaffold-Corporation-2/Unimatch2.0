import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/app_model.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/dialogs/progress_dialog.dart';
import 'package:uni_match/widgets/image_source_sheet.dart';
import 'package:uni_match/widgets/show_scaffold_msg.dart';
import 'package:uni_match/dialogs/common_dialogs.dart';
import 'package:url_launcher/url_launcher.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final AppController i18n = Modular.get();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final nameController = TextEditingController();
  final schoolController = TextEditingController();
  final jobController = TextEditingController();
  final bioController = TextEditingController();
  final numberController = TextEditingController();

  late ProgressDialog pr;
  String phoneCode = '+55'; // Define yor default phone code
  String initialSelection = 'BR'; // Define yor default country code

  void _navegarPaginas(String nomeRota) {
    Modular.to.navigate(nomeRota);
  }

  //bug ?? talvez
  @observable
  GlobalKey<FormState>? formKey;

  addForm() => formKey = GlobalKey<FormState>();

//******************************************************************************
  /// Login com Numéro ///
  ///
  progress(context) {
    pr = ProgressDialog(context, isDismissible: false);
  }

  /// Sign in with phone number
  void signIn(BuildContext context, mounted) async {
    // Show progress dialog
    pr.show(i18n.translate("processing")!);

    /// Verify user phone number
    await UserModel().verifyPhoneNumber(
        phoneNumber: phoneCode + numberController.text.trim(),
        checkUserAccount: () {
          /// Auth user account
          UserModel().authUserAccount(homeScreen: () {
            /// Go to home screen
            _navegarPaginas("/home");
          }, signUpScreen: () {
            /// Go to sign up screen

            _navegarPaginas("/login/signUp");
          });
        },
        codeSent: (code) async {
          // Hide progreess dialog
          pr.hide();
          // Go to verification code screen
          Modular.to
              .pushNamed('/login/signIn/phone/verification', arguments: code);

          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => VerificationCodeScreen(
          //       verificationId: code,
          //     )));
        },
        onError: (errorType) async {
          // Hide progreess dialog
          pr.hide();

          // Check Erro type
          if (errorType == 'invalid_number') {
            // Check error type
            final String message =
                i18n.translate("we_were_unable_to_verify_your_number")!;
            // Show error message
            // Validate context
            if (mounted) {
              showScaffoldMessage(
                  context: context, message: message, bgcolor: Colors.red);
            }
          }
        });
  }

  /// Check and request location permission
  Future<void> checkLocationPermission(
      {required VoidCallback onGpsDisabled,
      required VoidCallback onDenied,
      required VoidCallback onGranted}) async {
    /// Check if GPS is enabled
    if (!(await Geolocator.isLocationServiceEnabled())) {
      // Callback function
      onGpsDisabled();
      debugPrint('onGpsDisabled() -> disabled');
    } else {
      /// Request permission
      final LocationPermission permission =
          await Geolocator.requestPermission();

      switch (permission) {
        case LocationPermission.denied:
          onDenied();
          debugPrint('permission: denied');
          break;
        case LocationPermission.deniedForever:
          onDenied();
          debugPrint('permission: deniedForever');
          break;
        case LocationPermission.whileInUse:
          onGranted();
          debugPrint('permission: whileInUse');
          break;
        case LocationPermission.always:
          onGranted();
          debugPrint('permission: always');
          break;
      }
    }
  }

  //******************************************************************************
  /// Login Email ///
  // @action
  // Future<void> firebaseLogin(String userEmail, String userPassword) async {
  //   User currentUser;
  //
  //   await Future.delayed(Duration(seconds: 1));
  //   currentUser = await userRepository.firebaseLogin(userEmail, userPassword);
  //
  //   if (currentUser != null) {
  //     Modular.to.navigate('/home', arguments: currentUser);
  //     resetLoginIsWrong();
  //   } else {
  //     loginReallyIsWrong();
  //   }
  // }

  //******************************************************************************
  /// Login com Google ///
  @action
  Future<void> googleLogin() async {
    await UserModel().authGoogleAccount();
  }

//******************************************************************************
  /// Criar conta ///

  /// User Birthday info
  int userBirthDay = 0;
  int userBirthMonth = 0;
  int userBirthYear = DateTime.now().year;
  // End

  @observable
  bool isLoading = false;

  @observable
  DateTime initialDateTime = DateTime.now();

  @observable
  bool agreeTerms = false;

  @observable
  String? selectedGender;

  List<String> genders = ['Homem', 'Mulher', 'Outro'];

  @observable
  String? selectedOrientation;

  List<String> sexualOrientation = [
    'Heterossexual',
    'Homossexual',
    'Bissexual',
    'Assexual',
    'Pansexual'
  ];

  @observable
  String? birthday;

  @observable
  File? imageFile;

  @action
  nameBirthday() => birthday = i18n.translate("select_your_birthday");

  @action
  selecionarGenero(String gender) => selectedGender = gender;

  @action
  selecionarOrientacao(String orient) => selectedOrientation = orient;

  /// Set terms
  @action
  setAgreeTerms(bool value) => agreeTerms = value;

  /// Pegar imagem da camera / galeria
  @action
  getImage(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => ImageSourceSheet(
              onImageSelected: (image) {
                if (image != null) {
                  imageFile = image;
                  Navigator.of(context).pop();
                }
              },
            ));
  }

  @action
  updateUserBithdayInfo(DateTime date) {
    // Update the inicial date
    initialDateTime = date;
    // Set for label
    // birthday = date.toString().split(' ')[0];
    birthday = UtilData.obterDataDDMMAAAA(date);
    // User birthday info
    userBirthDay = date.day;
    userBirthMonth = date.month;
    userBirthYear = date.year;
  }

  // Get Date time picker app locale
  DateTimePickerLocale _getDatePickerLocale() {
    // Inicial value
    DateTimePickerLocale _locale = DateTimePickerLocale.pt_br;

    if (i18n.locale.toString() == 'pt_br') _locale = DateTimePickerLocale.pt_br;
    if (i18n.locale.toString() == 'en')
      _locale = DateTimePickerLocale.en_us;
    else
      _locale = DateTimePickerLocale.pt_br;

    return _locale;
  }

  /// Display date picker.
  @action
  showDatePicker(context) {
    DatePicker.showDatePicker(
      context,
      onMonthChangeStartWithFirstDate: true,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text(i18n.translate('DONE')!,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Theme.of(context).primaryColor)),
      ),
      minDateTime: DateTime(1920, 1, 1),
      maxDateTime: DateTime.now(),
      initialDateTime: initialDateTime,
      dateFormat: 'dd-MMMM-yyyy', // Date format
      locale: _getDatePickerLocale(), // Set your App Locale here
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        // Get birthday info
        updateUserBithdayInfo(dateTime);
      },
      onConfirm: (dateTime, List<int> index) {
        // Get birthday info
        updateUserBithdayInfo(dateTime);
      },
    );
  }

  /// Handle Create account
  createAccount(context) async {
    /// check image file
    if (imageFile == null) {
      // Show error message
      showScaffoldMessage(
          context: context,
          message: i18n.translate("please_select_your_profile_photo")!,
          bgcolor: Colors.red);
      // validate terms
    } else if (!agreeTerms) {
      // Show error message
      showScaffoldMessage(
          context: context,
          message: i18n.translate("you_must_agree_to_our_privacy_policy")!,
          bgcolor: Colors.red);

      /// Validate form
    } else if (selectedGender == null) {
      // Show error message
      showScaffoldMessage(
          context: context,
          message: i18n.translate("select_gender")!,
          bgcolor: Colors.red);

      /// Validate form
    } else if (selectedOrientation == null) {
      // Show error message
      showScaffoldMessage(
          context: context,
          message: i18n.translate("select_orientation")!,
          bgcolor: Colors.red);

      /// Validate form
    } else if (nameController.text.isEmpty) {
      // Show error message
      showScaffoldMessage(
          context: context,
          message: i18n.translate("enter_your_fullname")!,
          bgcolor: Colors.red);

      /// Validate form
    } else if (schoolController.text.isEmpty) {
      // Show error message
      showScaffoldMessage(
          context: context,
          message: i18n.translate("please_enter_your_school_name")!,
          bgcolor: Colors.red);

      /// Validate form
    } else if (UserModel().calculateUserAge(initialDateTime) < 18) {
      // Show error message
      showScaffoldMessage(
          context: context,
          duration: Duration(seconds: 7),
          message: i18n.translate(
              "only_18_years_old_and_above_are_allowed_to_create_an_account")!,
          bgcolor: Colors.red);
    } else if (!formKey!.currentState!.validate()) {
    } else {
      /// Call all input onSaved method
      formKey!.currentState!.save();
      isLoading = true;

      /// Call sign up method
      UserModel().signUp(
          userPhotoFile: imageFile!,
          userFullName: nameController.text.trim(),
          userGender: selectedGender!,
          userBirthDay: userBirthDay,
          userBirthMonth: userBirthMonth,
          userBirthYear: userBirthYear,
          userSchool: schoolController.text.trim(),
          userOrientation: selectedOrientation!,
          userBio: bioController.text.trim(),
          onSuccess: () async {
            // Show success message
            isLoading = false;
            successDialog(context,
                message: i18n
                    .translate("your_account_has_been_created_successfully")!,
                positiveAction: () {
              // Execute action
              Modular.to.navigate('/home');
            });
          },
          onFail: (error) {
            // Debug error
            isLoading = false;
            debugPrint(error);
            // Show error message
            errorDialog(context,
                message: i18n.translate(
                    "an_error_occurred_while_creating_your_account")!);
          });
    }
  }

//******************************************************************************
  /// Acessar - Google Play / Apple Store

  /// Open app store - Google Play / Apple Store
  Future<void> openAppStore() async {
    if (await canLaunch(_appStoreUrl)) {
      await launch(_appStoreUrl);
    } else {
      if (Platform.isAndroid) {
        throw "Não foi possível abrir o url da Play Store....";
      } else if (Platform.isIOS) {
        throw "Não foi possível abrir o url da App Store....";
      }
    }
  }

  /// Get app store URL - Google Play / Apple Store
  String get _appStoreUrl {
    String url = "";
    final String androidPackageName = AppModel().appInfo.androidPackageName;
    final String iOsAppId = AppModel().appInfo.iOsAppId;
    // Check device OS
    if (Platform.isAndroid) {
      url = "https://play.google.com/store/apps/details?id=$androidPackageName";
    } else if (Platform.isIOS) {
      url = "https://apps.apple.com/app/id$iOsAppId";
    }
    return url;
  }
}
