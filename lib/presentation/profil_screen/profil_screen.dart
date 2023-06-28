import 'bloc/profil_bloc.dart';
import 'models/profil_model.dart';
import 'package:flutter/material.dart';
import 'package:rainroot/core/app_export.dart';
import 'package:rainroot/core/utils/validation_functions.dart';
import 'package:rainroot/presentation/home_page/home_page.dart';
import 'package:rainroot/widgets/custom_bottom_bar.dart';
import 'package:rainroot/widgets/custom_button.dart';
import 'package:rainroot/widgets/custom_icon_button.dart';
import 'package:rainroot/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class ProfilScreen extends StatelessWidget {
  ProfilScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<ProfilBloc>(
        create: (context) =>
            ProfilBloc(ProfilState(profilModelObj: ProfilModel()))
              ..add(ProfilInitialEvent()),
        child: ProfilScreen());
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: double.maxFinite,
                              child: Container(
                                  width: double.maxFinite,
                                  padding: getPadding(
                                      left: 20, top: 17, right: 20, bottom: 17),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              ImageConstant.imgGroup6),
                                          fit: BoxFit.cover)),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomIconButton(
                                            height: 48,
                                            width: 48,
                                            margin: getMargin(top: 2),
                                            shape:
                                                IconButtonShape.CircleBorder24,
                                            onTap: () {
                                              onTapBtnArrowleft(context);
                                            },
                                            child: CustomImageView(
                                                svgPath: ImageConstant
                                                    .imgArrowleft)),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                height: getVerticalSize(106),
                                                width: getHorizontalSize(136),
                                                margin: getMargin(top: 28),
                                                child: Stack(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    children: [
                                                      CustomImageView(
                                                          imagePath:
                                                              ImageConstant
                                                                  .imgRectangle2,
                                                          height: getSize(106),
                                                          width: getSize(106),
                                                          radius: BorderRadius
                                                              .circular(
                                                                  getHorizontalSize(
                                                                      50)),
                                                          alignment: Alignment
                                                              .centerLeft),
                                                      CustomIconButton(
                                                          height: 48,
                                                          width: 48,
                                                          variant: IconButtonVariant
                                                              .OutlineBlack90033_1,
                                                          padding:
                                                              IconButtonPadding
                                                                  .PaddingAll6,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: CustomImageView(
                                                              svgPath:
                                                                  ImageConstant
                                                                      .imgCamera))
                                                    ])))
                                      ]))),
                          Padding(
                              padding: getPadding(top: 14),
                              child: Text("lbl_bonjour_clara2".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtH1Gray900)),
                          Padding(
                              padding: getPadding(left: 49, top: 32, right: 49),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: getPadding(left: 11),
                                        child: Text("lbl_pr_nom".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtBoutons)),
                                    BlocSelector<ProfilBloc, ProfilState,
                                            TextEditingController?>(
                                        selector: (state) =>
                                            state.firstnameController,
                                        builder:
                                            (context, firstnameController) {
                                          return CustomTextFormField(
                                              focusNode: FocusNode(),
                                              autofocus: true,
                                              controller: firstnameController,
                                              hintText: "lbl_clara".tr,
                                              margin: getMargin(top: 17),
                                              suffix: Container(
                                                  margin: getMargin(
                                                      left: 30,
                                                      top: 2,
                                                      right: 5,
                                                      bottom: 3),
                                                  child: CustomImageView(
                                                      svgPath: ImageConstant
                                                          .imgCheckmark)),
                                              suffixConstraints: BoxConstraints(
                                                  maxHeight:
                                                      getVerticalSize(34)));
                                        })
                                  ])),
                          Padding(
                              padding: getPadding(left: 49, top: 12, right: 49),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: getPadding(left: 11),
                                        child: Text("lbl_nom".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtBoutons)),
                                    BlocSelector<ProfilBloc, ProfilState,
                                            TextEditingController?>(
                                        selector: (state) =>
                                            state.lastnameController,
                                        builder: (context, lastnameController) {
                                          return CustomTextFormField(
                                              focusNode: FocusNode(),
                                              autofocus: true,
                                              controller: lastnameController,
                                              hintText: "lbl_tidjane".tr,
                                              margin: getMargin(top: 17),
                                              suffix: Container(
                                                  margin: getMargin(
                                                      left: 30,
                                                      top: 2,
                                                      right: 5,
                                                      bottom: 3),
                                                  child: CustomImageView(
                                                      svgPath: ImageConstant
                                                          .imgCheckmark)),
                                              suffixConstraints: BoxConstraints(
                                                  maxHeight:
                                                      getVerticalSize(34)));
                                        })
                                  ])),
                          Padding(
                              padding: getPadding(left: 50, top: 12, right: 48),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: getPadding(left: 11),
                                        child: Text("lbl_adresse_mail".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtBoutons)),
                                    BlocSelector<ProfilBloc, ProfilState,
                                            TextEditingController?>(
                                        selector: (state) =>
                                            state.emailController,
                                        builder: (context, emailController) {
                                          return CustomTextFormField(
                                              focusNode: FocusNode(),
                                              autofocus: true,
                                              controller: emailController,
                                              hintText:
                                                  "msg_claratidjane_email_com"
                                                      .tr,
                                              margin: getMargin(top: 17),
                                              textInputType:
                                                  TextInputType.emailAddress,
                                              suffix: Container(
                                                  margin: getMargin(
                                                      left: 30,
                                                      top: 3,
                                                      right: 6,
                                                      bottom: 2),
                                                  child: CustomImageView(
                                                      svgPath: ImageConstant
                                                          .imgCheckmark)),
                                              suffixConstraints: BoxConstraints(
                                                  maxHeight:
                                                      getVerticalSize(34)),
                                              validator: (value) {
                                                if (value == null ||
                                                    (!isValidEmail(value,
                                                        isRequired: true))) {
                                                  return "Please enter valid email";
                                                }
                                                return null;
                                              });
                                        })
                                  ])),
                          Padding(
                              padding: getPadding(left: 50, top: 13, right: 48),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: getPadding(left: 11),
                                        child: Text("lbl_mot_de_passe".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtBoutons)),
                                    BlocSelector<ProfilBloc, ProfilState,
                                            TextEditingController?>(
                                        selector: (state) =>
                                            state.languageController,
                                        builder: (context, languageController) {
                                          return CustomTextFormField(
                                              focusNode: FocusNode(),
                                              autofocus: true,
                                              controller: languageController,
                                              hintText: "msg".tr,
                                              margin: getMargin(top: 16),
                                              textInputAction:
                                                  TextInputAction.done,
                                              suffix: Container(
                                                  padding: getPadding(
                                                      left: 2,
                                                      top: 6,
                                                      right: 2,
                                                      bottom: 7),
                                                  margin: getMargin(
                                                      left: 30,
                                                      top: 2,
                                                      right: 12,
                                                      bottom: 2),
                                                  decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .whiteA700,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              getHorizontalSize(
                                                                  6))),
                                                  child: CustomImageView(
                                                      svgPath: ImageConstant
                                                          .imgEye)),
                                              suffixConstraints: BoxConstraints(
                                                  maxHeight:
                                                      getVerticalSize(34)));
                                        })
                                  ])),
                          CustomButton(
                              height: getVerticalSize(39),
                              text: "msg_confirmer_les_changements".tr,
                              margin: getMargin(left: 49, top: 76, right: 49),
                              onTap: () {
                                onTapConfirmerles(context);
                              }),
                          Spacer(),
                          Padding(
                              padding: getPadding(left: 49, right: 49),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomIconButton(
                                        height: 48,
                                        width: 48,
                                        margin: getMargin(bottom: 1),
                                        variant: IconButtonVariant
                                            .OutlineBlack90033_1,
                                        padding: IconButtonPadding.PaddingAll6,
                                        child: CustomImageView(
                                            svgPath: ImageConstant.imgHome)),
                                    CustomIconButton(
                                        height: 48,
                                        width: 48,
                                        margin: getMargin(top: 1),
                                        variant: IconButtonVariant
                                            .OutlineBlack90033_1,
                                        padding: IconButtonPadding.PaddingAll6,
                                        child: CustomImageView(
                                            svgPath: ImageConstant.imgUser)),
                                    CustomIconButton(
                                        height: 48,
                                        width: 48,
                                        margin: getMargin(bottom: 1),
                                        variant: IconButtonVariant
                                            .OutlineBlack90033_1,
                                        padding: IconButtonPadding.PaddingAll6,
                                        child: CustomImageView(
                                            svgPath: ImageConstant.imgCar))
                                  ]))
                        ]))),
            bottomNavigationBar:
                CustomBottomBar(onChanged: (BottomBarEnum type) {
              Navigator.pushNamed(
                  navigatorKey.currentContext!, getCurrentRoute(type));
            })));
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Iconeswhitea70048x48:
        return AppRoutes.homePage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage.builder(context);
      default:
        return DefaultWidget();
    }
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

  /// Navigates to the homeContainerScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the `NavigatorService`
  /// to push the named route for the homeContainerScreen.
  onTapConfirmerles(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.homeContainerScreen,
    );
  }
}
