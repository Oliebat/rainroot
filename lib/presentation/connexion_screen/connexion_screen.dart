import 'bloc/connexion_bloc.dart';
import 'models/connexion_model.dart';
import 'package:flutter/material.dart';
import 'package:rainroot/core/app_export.dart';
import 'package:rainroot/core/utils/validation_functions.dart';
import 'package:rainroot/widgets/custom_button.dart';
import 'package:rainroot/widgets/custom_icon_button.dart';
import 'package:rainroot/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class ConnexionScreen extends StatelessWidget {
  ConnexionScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<ConnexionBloc>(
        create: (context) =>
            ConnexionBloc(ConnexionState(connexionModelObj: ConnexionModel()))
              ..add(ConnexionInitialEvent()),
        child: ConnexionScreen());
  }

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
                              child: CustomImageView(
                                  svgPath: ImageConstant.imgArrowleft)),
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
                                            alignment: Alignment.topCenter),
                                        CustomImageView(
                                            imagePath: ImageConstant
                                                .img3dcasuallife215x242,
                                            height: getVerticalSize(215),
                                            width: getHorizontalSize(242),
                                            alignment: Alignment.centerLeft,
                                            margin: getMargin(left: 41))
                                      ]))),
                          Expanded(
                              child: Container(
                                  margin: getMargin(top: 1),
                                  padding: getPadding(
                                      left: 49, top: 36, right: 49, bottom: 36),
                                  decoration: AppDecoration.outlineBlack90033
                                      .copyWith(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder25),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("msg_authentification".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtH1),
                                        Padding(
                                            padding: getPadding(top: 88),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                      padding:
                                                          getPadding(left: 11),
                                                      child: Text(
                                                          "lbl_adresse_mail".tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtBoutons)),
                                                  BlocSelector<
                                                          ConnexionBloc,
                                                          ConnexionState,
                                                          TextEditingController?>(
                                                      selector: (state) =>
                                                          state.emailController,
                                                      builder: (context,
                                                          emailController) {
                                                        return CustomTextFormField(
                                                            focusNode:
                                                                FocusNode(),
                                                            autofocus: true,
                                                            controller:
                                                                emailController,
                                                            hintText:
                                                                "msg_johndoe_email_com"
                                                                    .tr,
                                                            margin: getMargin(
                                                                top: 17),
                                                            textInputType:
                                                                TextInputType
                                                                    .emailAddress,
                                                            suffix: Container(
                                                                margin:
                                                                    getMargin(
                                                                        left:
                                                                            30,
                                                                        top: 3,
                                                                        right:
                                                                            5,
                                                                        bottom:
                                                                            2),
                                                                child: CustomImageView(
                                                                    svgPath:
                                                                        ImageConstant
                                                                            .imgCheckmark)),
                                                            suffixConstraints:
                                                                BoxConstraints(
                                                                    maxHeight:
                                                                        getVerticalSize(
                                                                            34)),
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  (!isValidEmail(
                                                                      value,
                                                                      isRequired:
                                                                          true))) {
                                                                return "Please enter valid email";
                                                              }
                                                              return null;
                                                            });
                                                      })
                                                ])),
                                        Padding(
                                            padding: getPadding(top: 23),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                      padding:
                                                          getPadding(left: 11),
                                                      child: Text(
                                                          "lbl_mot_de_passe".tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtBoutons)),
                                                  BlocSelector<
                                                          ConnexionBloc,
                                                          ConnexionState,
                                                          TextEditingController?>(
                                                      selector: (state) => state
                                                          .languageController,
                                                      builder: (context,
                                                          languageController) {
                                                        return CustomTextFormField(
                                                            focusNode:
                                                                FocusNode(),
                                                            autofocus: true,
                                                            controller:
                                                                languageController,
                                                            hintText: "msg".tr,
                                                            margin: getMargin(
                                                                top: 16),
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,
                                                            suffix: Container(
                                                                padding: getPadding(
                                                                    left: 2,
                                                                    top: 6,
                                                                    right: 2,
                                                                    bottom: 7),
                                                                margin: getMargin(
                                                                    left: 30,
                                                                    top: 2,
                                                                    right: 11,
                                                                    bottom: 2),
                                                                decoration: BoxDecoration(
                                                                    color: ColorConstant
                                                                        .whiteA700,
                                                                    borderRadius:
                                                                        BorderRadius.circular(getHorizontalSize(
                                                                            6))),
                                                                child: CustomImageView(
                                                                    svgPath:
                                                                        ImageConstant
                                                                            .imgEye)),
                                                            suffixConstraints:
                                                                BoxConstraints(
                                                                    maxHeight:
                                                                        getVerticalSize(
                                                                            34)));
                                                      })
                                                ])),
                                        GestureDetector(
                                            onTap: () {
                                              onTapTxtMotdepasseoubli(context);
                                            },
                                            child: Padding(
                                                padding: getPadding(top: 10),
                                                child: Text(
                                                    "msg_mot_de_passe_oubli".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtParagraphe))),
                                        Spacer(),
                                        CustomButton(
                                            height: getVerticalSize(39),
                                            text: "lbl_connexion".tr,
                                            margin: getMargin(bottom: 92),
                                            variant:
                                                ButtonVariant.FillBluegray300,
                                            onTap: () {
                                              onTapConnexion(context);
                                            })
                                      ])))
                        ])))));
  }

  /// Navigates to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is
  /// used to build the navigation stack. When the action is triggered, this
  /// function uses the [NavigatorService] to navigate to the previous screen
  /// in the navigation stack.
  onTapBtnArrowleft(BuildContext context) {
    NavigatorService.goBack();
  }

  /// Navigates to the resetScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the `NavigatorService`
  /// to push the named route for the resetScreen.
  onTapTxtMotdepasseoubli(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.resetScreen,
    );
  }

  /// Navigates to the homeContainerScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the `NavigatorService`
  /// to push the named route for the homeContainerScreen.
  onTapConnexion(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.homeContainerScreen,
    );
  }
}
