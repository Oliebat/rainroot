import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rainroot/core/app_export.dart';
import 'package:rainroot/core/constants/utils.dart';
import 'package:rainroot/data/apiClient/api_client.dart' as api;
import 'package:rainroot/widgets/custom_button.dart';
import 'package:rainroot/widgets/custom_icon_button.dart';
import 'package:rainroot/widgets/custom_text_form_field.dart';

class ConnexionScreen extends StatefulWidget {
  ConnexionScreen({Key? key}) : super(key: key);

  static WidgetBuilder get builder =>
      (BuildContext context) => ConnexionScreen();

  @override
  _ConnexionScreenState createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = FlutterSecureStorage();
  bool fieldsEmptyError = false;
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
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
                    height: getVerticalSize(221),
                    width: getHorizontalSize(352),
                    margin: getMargin(top: 10, right: 23),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        CustomImageView(
                          svgPath: ImageConstant.imgVector1,
                          height: getVerticalSize(155),
                          width: getHorizontalSize(352),
                          alignment: Alignment.topCenter,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.img3dcasuallife215x242,
                          height: getVerticalSize(215),
                          width: getHorizontalSize(242),
                          alignment: Alignment.centerLeft,
                          margin: getMargin(left: 41),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: getMargin(top: 1),
                    padding: getPadding(
                      left: 49,
                      top: 36,
                      right: 49,
                      bottom: 36,
                    ),
                    decoration: AppDecoration.outlineBlack90033.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder25,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "msg_authentification".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtH1,
                        ),
                        SizedBox(height: getVerticalSize(70)),
                        CustomTextFormField(
                          controller: _emailController,
                          hintText: "email".tr,
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
                          hintText: "mot_de_passe".tr,
                          isObscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre mot de passe';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: getVerticalSize(70)),
                        if (fieldsEmptyError)
                          Text(
                            'Vos champs sont vides',
                            style: TextStyle(color: Colors.red),
                          ),
                        if (errorMsg != null)
                          Text(
                            errorMsg!,
                            style: TextStyle(color: Colors.red),
                          ),
                        CustomButton(
                          height: getVerticalSize(39),
                          text: "lbl_connexion".tr,
                          margin: getMargin(bottom: 92),
                          variant: ButtonVariant.FillBluegray300,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              var email = _emailController.text;
                              var password = _passwordController.text;

                              if (email.isEmpty || password.isEmpty) {
                                setState(() {
                                  fieldsEmptyError = true;
                                });
                              } else {
                                setState(() {
                                  fieldsEmptyError = false;
                                });
                                try {
                                  print('Before API call');
                                  var data =
                                      await api.userLogin(email, password);
                                  print('After API call, data: $data');
                                  if (data.containsKey('accessToken')) {
                                    print('Token received, writing to storage');
                                    await storage.write(
                                        key: 'auth_token',
                                        value: data['accessToken']);
                                    print('After writing to storage');
                                    print('Navigating to HomeContainerScreen');
                                    NavigatorService.pushNamed(
                                        AppRoutes.homeContainerScreen);
                                    print('Navigation should have occurred');
                                  } else {
                                    // Handle incorrect credentials
                                    print('No token in response data');
                                  }
                                } catch (e) {
                                  print('Error during login process: $e');
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

  void onTapBtnArrowleft(BuildContext context) {
    NavigatorService.goBack();
  }
}
