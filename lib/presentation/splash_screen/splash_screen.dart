import 'bloc/splash_bloc.dart';
import 'models/splash_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:rainroot/core/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<SplashBloc>(
        create: (context) =>
            SplashBloc(SplashState(splashModelObj: SplashModel()))
              ..add(SplashInitialEvent()),
        child: SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              backgroundColor: ColorConstant.whiteA700,
              body: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: getPadding(right: 3, bottom: 5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: getVerticalSize(117),
                                      width: getHorizontalSize(176),
                                      child: Stack(
                                          alignment: Alignment.bottomLeft,
                                          children: [
                                            Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                    height:
                                                        getVerticalSize(117),
                                                    width:
                                                        getHorizontalSize(176),
                                                    padding: getPadding(
                                                        left: 36, right: 36),
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
                                                          height:
                                                              getVerticalSize(
                                                                  53),
                                                          width:
                                                              getHorizontalSize(
                                                                  54),
                                                          alignment: Alignment
                                                              .bottomRight)
                                                    ]))),
                                            CustomImageView(
                                                svgPath: ImageConstant
                                                    .imgVectorBlueGray700,
                                                height: getVerticalSize(84),
                                                width: getHorizontalSize(85),
                                                alignment: Alignment.bottomLeft)
                                          ])),
                                  CustomImageView(
                                      svgPath:
                                          ImageConstant.imgVectorDeepOrange100,
                                      height: getVerticalSize(92),
                                      width: getHorizontalSize(176)),
                                  Padding(
                                      padding: getPadding(top: 9),
                                      child: Text("lbl_rainroot".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style:
                                              AppStyle.txtComfortaaRegular40))
                                ]))
                      ]))));
    });
  }
}
