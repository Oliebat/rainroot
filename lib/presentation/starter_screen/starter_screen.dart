import 'bloc/starter_bloc.dart';
import 'models/starter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:rainroot/core/app_export.dart';
import 'package:rainroot/widgets/custom_button.dart';

class StarterScreen extends StatelessWidget {
  const StarterScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<StarterBloc>(
        create: (context) =>
            StarterBloc(StarterState(starterModelObj: StarterModel()))
              ..add(StarterInitialEvent()),
        child: StarterScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StarterBloc, StarterState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              backgroundColor: ColorConstant.whiteA700,
              body: Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                      color: ColorConstant.whiteA700,
                      image: DecorationImage(
                          image: AssetImage(ImageConstant.imgStarter),
                          fit: BoxFit.cover)),
                  child: Container(
                      width: double.maxFinite,
                      padding: getPadding(left: 49, right: 49),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding:
                                    getPadding(left: 70, top: 86, right: 73),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: getHorizontalSize(123),
                                          margin:
                                              getMargin(left: 33, right: 29),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: fs.Svg(
                                                      ImageConstant.imgGroup2),
                                                  fit: BoxFit.cover)),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgVectorBlueGray700,
                                                    height: getVerticalSize(58),
                                                    width:
                                                        getHorizontalSize(59),
                                                    margin: getMargin(top: 23)),
                                                CustomImageView(
                                                    svgPath:
                                                        ImageConstant.imgVector,
                                                    height: getSize(37),
                                                    width: getSize(37),
                                                    margin: getMargin(
                                                        top: 44, right: 25))
                                              ])),
                                      CustomImageView(
                                          svgPath: ImageConstant
                                              .imgVectorDeepOrange100,
                                          height: getVerticalSize(64),
                                          width: getHorizontalSize(123)),
                                      Padding(
                                          padding: getPadding(top: 5),
                                          child: Text("lbl_rainroot".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtComfortaaRegular40))
                                    ])),
                            Container(
                                width: getHorizontalSize(278),
                                margin: getMargin(left: 26, top: 69, right: 24),
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: "lbl_entretenez_vos".tr,
                                          style: TextStyle(
                                              color: ColorConstant.blueGray700,
                                              fontSize: getFontSize(36),
                                              fontFamily: 'Comfortaa',
                                              fontWeight: FontWeight.w700)),
                                      TextSpan(
                                          text: "lbl_plantes".tr,
                                          style: TextStyle(
                                              color: ColorConstant.blueGray300,
                                              fontSize: getFontSize(36),
                                              fontFamily: 'Comfortaa',
                                              fontWeight: FontWeight.w700)),
                                      TextSpan(
                                          text: "lbl_avec_facilit".tr,
                                          style: TextStyle(
                                              color: ColorConstant.blueGray700,
                                              fontSize: getFontSize(36),
                                              fontFamily: 'Comfortaa',
                                              fontWeight: FontWeight.w700))
                                    ]),
                                    textAlign: TextAlign.center)),
                            Padding(
                                padding: getPadding(top: 76),
                                child: Text("msg_arrosage_et_entretien".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtH2Bluegray700)),
                            Spacer(),
                            CustomButton(
                                height: getVerticalSize(47),
                                text: "lbl_explorer".tr,
                                shape: ButtonShape.RoundedBorder23,
                                fontStyle:
                                    ButtonFontStyle.WorkSansRomanSemiBold20,
                                onTap: () {
                                  onTapExplorer(context);
                                })
                          ])))));
    });
  }

  /// Navigates to the pageConnexionScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the `NavigatorService`
  /// to push the named route for the pageConnexionScreen.
  onTapExplorer(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.pageConnexionScreen,
    );
  }
}
