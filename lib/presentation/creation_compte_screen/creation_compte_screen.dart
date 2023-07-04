import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rainroot/core/app_export.dart';
import 'package:rainroot/core/utils/validation_functions.dart';
import 'package:rainroot/data/apiClient/api_client.dart' as api;
import 'package:rainroot/widgets/custom_button.dart';
import 'package:rainroot/widgets/custom_icon_button.dart';
import 'package:rainroot/widgets/custom_text_form_field.dart';

class CreationCompteScreen extends StatefulWidget {
  CreationCompteScreen({Key? key}) : super(key: key);

  static WidgetBuilder get builder =>
      (BuildContext context) => CreationCompteScreen();

  @override
  _CreationCompteScreenState createState() => _CreationCompteScreenState();
}

class _CreationCompteScreenState extends State<CreationCompteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = FlutterSecureStorage();
  bool fieldsEmptyError = false;
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomIconButton(
                  height: 48,
                  width: 48,
                  margin: getMargin(left: 20, top: 20),
                  shape: IconButtonShape.CircleBorder24,
                  onTap: () {
                    onTapBtnArrowleft(context);
                  },
                  child: CustomImageView(svgPath: ImageConstant.imgArrowleft),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: getVerticalSize(197),
                    width: getHorizontalSize(352),
                    margin: getMargin(top: 10, right: 23),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        CustomImageView(
                          svgPath: ImageConstant.imgVector1,
                          height: getVerticalSize(155),
                          width: getHorizontalSize(352),
                          alignment: Alignment.topCenter,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.img3dcasuallife,
                          height: getVerticalSize(185),
                          width: getHorizontalSize(180),
                          alignment: Alignment.bottomLeft,
                          margin: getMargin(left: 65),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Container(
                    margin: getMargin(top: 25),
                    padding: getPadding(
                      left: 48,
                      top: 38,
                      right: 48,
                      bottom: 38,
                    ),
                    decoration: AppDecoration.outlineBlack90033.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder25,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "msg_cr_ation_de_compte".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtH1,
                        ),
                        SizedBox(height: getVerticalSize(40)),
                        CustomTextFormField(
                          controller: _firstNameController,
                          hintText: "Prénom".tr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre prénom';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: getVerticalSize(40)),
                        CustomTextFormField(
                          controller: _nameController,
                          hintText: "Nom".tr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre nom';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: getVerticalSize(40)),
                        CustomTextFormField(
                          controller: _emailController,
                          hintText: "Email".tr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre adresse e-mail';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: getVerticalSize(40)),
                        CustomTextFormField(
                          controller: _passwordController,
                          hintText: "Mot de passe".tr,
                          isObscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre mot de passe';
                            }
                            return null;
                          },
                        ),
                        CustomButton(
                          height: getVerticalSize(39),
                          text: "lbl_s_inscrire".tr,
                          margin: getMargin(top: 52, bottom: 90),
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              var firstName = _firstNameController.text;
                              var lastName = _nameController.text;
                              var email = _emailController.text;
                              var password = _passwordController.text;

                              if (email.isEmpty ||
                                  password.isEmpty ||
                                  firstName.isEmpty ||
                                  lastName.isEmpty) {
                                setState(() {
                                  fieldsEmptyError = true;
                                });
                              } else {
                                setState(() {
                                  fieldsEmptyError = false;
                                });
                                try {
                                  var data = await api.createUser(
                                    firstName,
                                    lastName,
                                    email,
                                    password,
                                  );

                                  print('Data from createUser: $data');

                                  if (data.containsKey('accessToken')) {
                                    await storage.write(
                                      key: 'auth_token',
                                      value: data['accessToken'],
                                    );

                                    showSnackbar('Création du compte réussie');
                                    NavigatorService.pushNamed(
                                      AppRoutes.homePage,
                                    );
                                  } else if (data.containsKey('error')) {
                                    showSnackbar(data[
                                        'error']); // Show the error message from the server
                                  } else {
                                    showSnackbar(
                                        'Erreur lors de la création du compte');
                                  }
                                } catch (e) {
                                  showSnackbar(
                                      'Une erreur inattendue est survenue');
                                  print('Error during account creation: $e');
                                }
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.black,
      ),
    );
  }

  void onTapBtnArrowleft(BuildContext context) {
    NavigatorService.goBack();
  }

  void onTapSinscrire(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.homeContainerScreen);
  }
}
