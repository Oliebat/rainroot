import 'bloc/page_connexion_bloc.dart';
import 'models/page_connexion_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:rainroot/core/app_export.dart';
import 'package:rainroot/widgets/custom_button.dart';
import 'package:rainroot/widgets/custom_icon_button.dart';

class PageConnexionScreen extends StatelessWidget {
  const PageConnexionScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<PageConnexionBloc>(
        create: (context) => PageConnexionBloc(
            PageConnexionState(pageConnexionModelObj: PageConnexionModel()))
          ..add(PageConnexionInitialEvent()),
        child: PageConnexionScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageConnexionBloc, PageConnexionState>(
        builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              backgroundColor: ColorConstant.whiteA700,
              body: Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 20, top: 20, right: 20, bottom: 15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomIconButton(
                            height: 48,
                            width: 48,
                            shape: IconButtonShape.CircleBorder24,
                            alignment: Alignment.centerLeft,
                            onTap: () {
                              onTapBtnArrowleft(context);
                            },
                            child: CustomImageView(
                                svgPath: ImageConstant.imgArrowleft)),
                        Spacer(),
                        Padding(
                            padding: getPadding(left: 99, right: 102),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: getVerticalSize(206),
                                      width: getHorizontalSize(170),
                                      child: Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                    height:
                                                        getVerticalSize(115),
                                                    width:
                                                        getHorizontalSize(170),
                                                    padding: getPadding(
                                                        left: 35, right: 35),
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: fs.Svg(
                                                                ImageConstant
                                                                    .imgGroup2),
                                                            fit: BoxFit.cover)),
                                                    child: Stack(children: [
                                                      CustomImageView(
                                                          svgPath: ImageConstant
                                                              .imgVector,
                                                          height: getSize(52),
                                                          width: getSize(52),
                                                          alignment: Alignment
                                                              .bottomRight)
                                                    ]))),
                                            CustomImageView(
                                                svgPath: ImageConstant
                                                    .imgVectorBlueGray700,
                                                height: getVerticalSize(83),
                                                width: getHorizontalSize(82),
                                                alignment: Alignment.topLeft,
                                                margin: getMargin(top: 32)),
                                            CustomImageView(
                                                svgPath: ImageConstant
                                                    .imgVectorDeepOrange100,
                                                height: getVerticalSize(90),
                                                width: getHorizontalSize(170),
                                                alignment:
                                                    Alignment.bottomCenter)
                                          ])),
                                  Padding(
                                      padding: getPadding(top: 9),
                                      child: Text("lbl_rainroot".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style:
                                              AppStyle.txtComfortaaRegular40))
                                ])),
                        Container(
                            width: getHorizontalSize(245),
                            margin: getMargin(top: 35),
                            child: Text("msg_bienvenue_nous".tr,
                                maxLines: null,
                                textAlign: TextAlign.center,
                                style: AppStyle.txtH2)),
                        CustomButton(
                            height: getVerticalSize(39),
                            text: "lbl_s_inscrire".tr,
                            margin: getMargin(left: 29, top: 34, right: 29),
                            onTap: () {
                              onTapSinscrire(context);
                            }),
                        CustomButton(
                            height: getVerticalSize(39),
                            text: "lbl_connexion".tr,
                            margin: getMargin(left: 29, top: 20, right: 29),
                            variant: ButtonVariant.FillBluegray300,
                            onTap: () {
                              onTapConnexion(context);
                            }),
                        Padding(
                            padding: getPadding(top: 19, right: 3),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                      padding: getPadding(top: 7, bottom: 6),
                                      child: SizedBox(
                                          width: getHorizontalSize(140),
                                          child: Divider(
                                              height: getVerticalSize(1),
                                              thickness: getVerticalSize(1),
                                              color:
                                                  ColorConstant.blueGray100))),
                                  Text("lbl_ou_utiliser".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtParagraphe),
                                  Padding(
                                      padding: getPadding(top: 7, bottom: 6),
                                      child: SizedBox(
                                          width: getHorizontalSize(140),
                                          child: Divider(
                                              height: getVerticalSize(1),
                                              thickness: getVerticalSize(1),
                                              color:
                                                  ColorConstant.blueGray100)))
                                ])),
                        Padding(
                            padding: getPadding(top: 15, bottom: 168),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: getSize(30),
                                      padding: getPadding(
                                          left: 11,
                                          top: 5,
                                          right: 11,
                                          bottom: 5),
                                      decoration: AppDecoration
                                          .txtFillBluegray10001
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .txtCircleBorder15),
                                      child: Text("lbl_f".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtWorkSansRomanMedium16)),
                                  Container(
                                      width: getSize(30),
                                      margin: getMargin(left: 5),
                                      padding: getPadding(
                                          left: 3, top: 4, right: 3, bottom: 4),
                                      decoration: AppDecoration
                                          .txtFillBluegray10001
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .txtCircleBorder15),
                                      child: Text("lbl_g".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtWorkSansRomanMedium16))
                                ]))
                      ]))));
    });
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

  /// Navigates to the creationCompteScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the `NavigatorService`
  /// to push the named route for the creationCompteScreen.
  onTapSinscrire(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.creationCompteScreen,
    );
  }

  /// Navigates to the connexionScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the `NavigatorService`
  /// to push the named route for the connexionScreen.
  onTapConnexion(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.connexionScreen,
    );
  }
}
