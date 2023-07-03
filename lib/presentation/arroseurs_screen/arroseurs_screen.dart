import 'bloc/arroseurs_bloc.dart';
import 'models/arroseurs_model.dart';
import 'package:flutter/material.dart';
import 'package:rainroot/core/app_export.dart';
import 'package:rainroot/presentation/home_page/home_page.dart';
import 'package:rainroot/widgets/custom_bottom_bar.dart';
import 'package:rainroot/widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class ArroseursScreen extends StatelessWidget {
  ArroseursScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    return BlocProvider<ArroseursBloc>(
        create: (context) =>
            ArroseursBloc(ArroseursState(arroseursModelObj: ArroseursModel()))
              ..add(ArroseursInitialEvent()),
        child: ArroseursScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArroseursBloc, ArroseursState>(
        builder: (context, state) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: SizedBox(
            width: double.maxFinite,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                  height: getVerticalSize(254),
                  width: double.maxFinite,
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            padding: getPadding(all: 20),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(ImageConstant.imgGroup6),
                                    fit: BoxFit.cover)),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomIconButton(
                                      height: 48,
                                      width: 48,
                                      shape: IconButtonShape.CircleBorder24,
                                      onTap: () {
                                        onTapBtnArrowleft(context);
                                      },
                                      child: CustomImageView(
                                          svgPath: ImageConstant.imgArrowleft)),
                                  Padding(
                                      padding: getPadding(top: 15, bottom: 89),
                                      child: Text("lbl_mes_robots".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtH1Gray900))
                                ]))),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                            width: getHorizontalSize(321),
                            child: Text("msg_ajoutez_et_de_configurez".tr,
                                maxLines: null,
                                textAlign: TextAlign.center,
                                style: AppStyle.txtParagraphe)))
                  ])),
              Container(
                  height: getVerticalSize(479),
                  width: getHorizontalSize(408),
                  margin: getMargin(top: 33, bottom: 5),
                  child: Stack(alignment: Alignment.topLeft, children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                            height: getVerticalSize(465),
                            width: getHorizontalSize(381),
                            child:
                                Stack(alignment: Alignment.topRight, children: [
                              CustomImageView(
                                  imagePath: ImageConstant.imgCasuallife3d,
                                  height: getVerticalSize(465),
                                  width: getHorizontalSize(381),
                                  alignment: Alignment.center),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      margin: getMargin(top: 105, right: 62),
                                      color: ColorConstant.blueGray700,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder50),
                                      child: Container(
                                          height: getSize(100),
                                          width: getSize(100),
                                          padding: getPadding(all: 21),
                                          decoration: AppDecoration
                                              .outlineBlack9003f2
                                              .copyWith(
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder50),
                                          child: Stack(children: [
                                            CustomImageView(
                                                svgPath: ImageConstant.imgPlus,
                                                height: getSize(56),
                                                width: getSize(56),
                                                alignment: Alignment.center)
                                          ]))))
                            ]))),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin: getMargin(top: 54),
                            padding: getPadding(all: 10),
                            decoration: AppDecoration.outlineBlack900331
                                .copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder20),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      margin: EdgeInsets.all(0),
                                      color: ColorConstant.whiteA700,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder20),
                                      child: Container(
                                          height: getVerticalSize(133),
                                          width: getHorizontalSize(161),
                                          padding: getPadding(
                                              left: 33,
                                              top: 24,
                                              right: 33,
                                              bottom: 24),
                                          decoration: AppDecoration
                                              .fillWhiteA700
                                              .copyWith(
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder20),
                                          child: Stack(children: [
                                            CustomImageView(
                                                svgPath: ImageConstant.imgMap,
                                                height: getVerticalSize(80),
                                                width: getHorizontalSize(93),
                                                alignment: Alignment.topCenter)
                                          ]))),
                                  Padding(
                                      padding: getPadding(top: 19, bottom: 8),
                                      child: Text("lbl_robosprinkle".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtH2Black900))
                                ]))),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            padding: getPadding(all: 10),
                            decoration: AppDecoration.outlineBlack900331
                                .copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder20),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      margin: EdgeInsets.all(0),
                                      color: ColorConstant.whiteA700,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder20),
                                      child: Container(
                                          height: getVerticalSize(133),
                                          width: getHorizontalSize(161),
                                          padding: getPadding(
                                              left: 46,
                                              top: 28,
                                              right: 46,
                                              bottom: 28),
                                          decoration: AppDecoration
                                              .fillWhiteA700
                                              .copyWith(
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder20),
                                          child: Stack(children: [
                                            CustomImageView(
                                                svgPath: ImageConstant
                                                    .imgUserBlueGray700,
                                                height: getVerticalSize(76),
                                                width: getHorizontalSize(67),
                                                alignment: Alignment.center)
                                          ]))),
                                  Padding(
                                      padding: getPadding(top: 18, bottom: 9),
                                      child: Text("lbl_waterwise".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtH2Black900))
                                ]))),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                            margin: getMargin(right: 20),
                            padding: getPadding(all: 10),
                            decoration: AppDecoration.outlineBlack900331
                                .copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder20),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      margin: EdgeInsets.all(0),
                                      color: ColorConstant.whiteA700,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder20),
                                      child: Container(
                                          height: getVerticalSize(133),
                                          width: getHorizontalSize(161),
                                          padding: getPadding(
                                              left: 42,
                                              top: 28,
                                              right: 42,
                                              bottom: 28),
                                          decoration: AppDecoration
                                              .fillWhiteA700
                                              .copyWith(
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder20),
                                          child: Stack(children: [
                                            CustomImageView(
                                                svgPath: ImageConstant
                                                    .imgUserBlueGray70076x76,
                                                height: getSize(76),
                                                width: getSize(76),
                                                alignment: Alignment.center)
                                          ]))),
                                  Padding(
                                      padding: getPadding(top: 20, bottom: 7),
                                      child: Text("lbl_aquabot".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtH2Black900))
                                ])))
                  ]))
            ])),
        bottomNavigationBar: CustomBottomBar(
          onChanged: (BottomBarEnum type) {
            Navigator.of(context).pushNamed(
              getCurrentRoute(type),
            );
          },
        ),
      ));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homePage;
      case BottomBarEnum.Profil:
        return AppRoutes.profilScreen;
      case BottomBarEnum.Spinkler:
        return AppRoutes.arroseursScreen;
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
}
