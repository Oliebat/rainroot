import 'bloc/reset_bloc.dart';
import 'models/reset_model.dart';
import 'package:flutter/material.dart';
import 'package:rainroot/core/app_export.dart';
import 'package:rainroot/core/utils/validation_functions.dart';
import 'package:rainroot/widgets/custom_button.dart';
import 'package:rainroot/widgets/custom_icon_button.dart';
import 'package:rainroot/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class ResetScreen extends StatelessWidget {
  ResetScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<ResetBloc>(
        create: (context) => ResetBloc(ResetState(resetModelObj: ResetModel()))
          ..add(ResetInitialEvent()),
        child: ResetScreen());
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
                                  height: getVerticalSize(219),
                                  width: getHorizontalSize(352),
                                  margin: getMargin(top: 10, right: 23),
                                  child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        CustomImageView(
                                            svgPath: ImageConstant.imgVector1,
                                            height: getVerticalSize(155),
                                            width: getHorizontalSize(352),
                                            alignment: Alignment.topCenter),
                                        CustomImageView(
                                            imagePath: ImageConstant
                                                .img3dcasuallife181x251,
                                            height: getVerticalSize(181),
                                            width: getHorizontalSize(251),
                                            alignment: Alignment.bottomCenter)
                                      ]))),
                          Expanded(
                              child: Container(
                                  margin: getMargin(top: 3),
                                  padding: getPadding(
                                      left: 47, top: 37, right: 47, bottom: 37),
                                  decoration: AppDecoration.outlineBlack90033
                                      .copyWith(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder25),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("msg_r_initialisation".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style:
                                                AppStyle.txtComfortaaRegular20),
                                        Padding(
                                            padding: getPadding(
                                                left: 2, top: 91, right: 2),
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
                                                          ResetBloc,
                                                          ResetState,
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
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,
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
                                                                    svgPath: ImageConstant
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
                                        Container(
                                            width: getHorizontalSize(311),
                                            margin: getMargin(
                                                left: 11, top: 96, right: 11),
                                            child: Text(
                                                "msg_un_email_de_confirmation"
                                                    .tr,
                                                maxLines: null,
                                                textAlign: TextAlign.center,
                                                style: AppStyle
                                                    .txtParagrapheBlack900)),
                                        Spacer(),
                                        CustomButton(
                                            height: getVerticalSize(39),
                                            text: "lbl_confirmer".tr,
                                            margin: getMargin(bottom: 91),
                                            variant:
                                                ButtonVariant.FillBluegray300,
                                            onTap: () {
                                              onTapConfirmer(context);
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

  /// Navigates to the connexionScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the `NavigatorService`
  /// to push the named route for the connexionScreen.
  onTapConfirmer(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.connexionScreen,
    );
  }
}
