import 'bloc/mon_arroseur_bloc.dart';
import 'models/mon_arroseur_model.dart';
import 'package:flutter/material.dart';
import 'package:rainroot/core/app_export.dart';
import 'package:rainroot/presentation/home_page/home_page.dart';
import 'package:rainroot/widgets/custom_bottom_bar.dart';
import 'package:rainroot/widgets/custom_button.dart';
import 'package:rainroot/widgets/custom_icon_button.dart';
import 'package:rainroot/widgets/custom_switch.dart';
import 'package:rainroot/data/apiClient/api_client.dart' as api;
import 'package:rainroot/core/constants/utils.dart';

// ignore_for_file: must_be_immutable
class MonArroseurScreen extends StatefulWidget {
  MonArroseurScreen({Key? key}) : super(key: key);
  static WidgetBuilder get builder =>
      (BuildContext context) => MonArroseurScreen();

  @override
  _MonArroseurScreenState createState() => _MonArroseurScreenState();
}

class _MonArroseurScreenState extends State<MonArroseurScreen> {
  Future<List<Sprinkler>>? _sprinklerFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   _getMySprinklers();
  // }

  // void _getMySprinklers() async {
  //   // Get sprinklers data from API
  //   setState(() {
  //     _sprinklerFuture = api.getMySprinklers();
  //   });
  //   _sprinklerFuture!.then((sprinklers) {
  //     print(
  //         'Sprinklers at homepage: $sprinklers'); // Print the sprinkler objects
  //   }).catchError((error) {
  //     // If an error occurred while getting sprinklers data, show an error
  //     setState(() {
  //       _sprinklerFuture = Future.error('Failed to load sprinklers');
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return FutureBuilder<List<Sprinkler>>(
      future: _sprinklerFuture,
      builder: (BuildContext context,
          AsyncSnapshot<List<Sprinkler>> sprinklerSnapshot) {
        if (sprinklerSnapshot.connectionState == ConnectionState.waiting) {
          // If the future is not completed, show a loading indicator
          return CircularProgressIndicator();
        } else if (sprinklerSnapshot.hasError) {
          // If the future completed with an error, display it
          return Text('Error: ${sprinklerSnapshot.error}');
        } else if (!sprinklerSnapshot.hasData) {
          // If the future completed but there's no data, display a message
          return Text('No sprinkler data available');
        } else {
          // The future has been completed, use the sprinkler data
          List<Sprinkler> sprinklers = sprinklerSnapshot.data!;

          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorConstant.whiteA700,
              body: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getVerticalSize(397),
                      width: double.maxFinite,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              padding: getPadding(all: 20),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(ImageConstant.imgGroup6),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                                      svgPath: ImageConstant.imgArrowleft,
                                    ),
                                  ),
                                  Padding(
                                    padding: getPadding(top: 15, bottom: 88),
                                    child: Text(
                                      "lbl_robosprinkle".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtH1Gray900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgCasuallife3d285x250,
                            height: getVerticalSize(285),
                            width: getHorizontalSize(250),
                            alignment: Alignment.bottomRight,
                            margin: getMargin(right: 52),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(left: 54, right: 53),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: getPadding(top: 5, bottom: 5),
                            child: Text(
                              "msg_tat_de_l_arrosage".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtParagraphe,
                            ),
                          ),
                          BlocSelector<MonArroseurBloc, MonArroseurState,
                              bool?>(
                            selector: (state) => state.isSelectedSwitch,
                            builder: (context, isSelectedSwitch) {
                              return CustomSwitch(
                                value: isSelectedSwitch,
                                onChanged: (value) {
                                  context
                                      .read<MonArroseurBloc>()
                                      .add(ChangeSwitchEvent(value: value));
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: getMargin(left: 51, top: 30, right: 50),
                      padding: getPadding(all: 8),
                      decoration: AppDecoration.outlineBluegray700.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: getPadding(top: 12, bottom: 10),
                            child: Text(
                              "msg_programme_d_arrosage".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtParagraphe,
                            ),
                          ),
                          CustomIconButton(
                            height: 38,
                            width: 38,
                            variant: IconButtonVariant.OutlineBlack90033_2,
                            padding: IconButtonPadding.PaddingAll3,
                            child: CustomImageView(
                              svgPath: ImageConstant.imgUserWhiteA700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: getMargin(left: 51, top: 30, right: 50),
                      padding: getPadding(all: 8),
                      decoration: AppDecoration.outlineBluegray700.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: getPadding(top: 12, bottom: 10),
                            child: Text(
                              "msg_heure_d_arrosage".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtParagraphe,
                            ),
                          ),
                          CustomIconButton(
                            height: 38,
                            width: 38,
                            variant: IconButtonVariant.OutlineBlack90033_2,
                            padding: IconButtonPadding.PaddingAll3,
                            child: CustomImageView(
                              svgPath: ImageConstant.imgClockWhiteA700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(left: 51, top: 39, right: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: getMargin(top: 1),
                            padding: getPadding(
                                left: 10, top: 8, right: 10, bottom: 8),
                            decoration: AppDecoration.fillBluegray100.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: getHorizontalSize(74),
                                  child: Text(
                                    "msg_temp_rature_interieure2".tr,
                                    maxLines: null,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtParagraphe,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: getPadding(right: 15, bottom: 1),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              getPadding(top: 7, bottom: 6),
                                          child: Text(
                                            "lbl_24".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtH1Gray900,
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(left: 15),
                                          child: Text(
                                            "lbl_c".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtComfortaaRegular36Gray900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: getMargin(left: 17),
                            padding: getPadding(
                                left: 10, top: 7, right: 10, bottom: 7),
                            decoration: AppDecoration.fillBluegray100.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: getPadding(top: 3),
                                  child: Text(
                                    "lbl_humidit".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtParagrapheBlack900,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: getPadding(top: 20, right: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: getPadding(bottom: 9),
                                          child: Text(
                                            "lbl_11".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtH1,
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(left: 11),
                                          child: Text(
                                            "lbl_g_m3".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtComfortaaRegular32Black900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      height: getVerticalSize(39),
                      text: "msg_confirmer_les_changements".tr,
                      margin: getMargin(left: 49, top: 39, right: 49),
                      onTap: () {
                        onTapConfirmerles(context);
                      },
                    ),
                    Padding(
                      padding: getPadding(left: 49, top: 59, right: 49),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconButton(
                            height: 48,
                            width: 48,
                            margin: getMargin(bottom: 1),
                            variant: IconButtonVariant.OutlineBlack90033_1,
                            padding: IconButtonPadding.PaddingAll6,
                            child: CustomImageView(
                              svgPath: ImageConstant.imgHome,
                            ),
                          ),
                          CustomIconButton(
                            height: 48,
                            width: 48,
                            margin: getMargin(top: 1),
                            variant: IconButtonVariant.OutlineBlack90033_1,
                            padding: IconButtonPadding.PaddingAll6,
                            child: CustomImageView(
                              svgPath: ImageConstant.imgUser,
                            ),
                          ),
                          CustomIconButton(
                            height: 48,
                            width: 48,
                            margin: getMargin(bottom: 1),
                            variant: IconButtonVariant.OutlineBlack90033_1,
                            padding: IconButtonPadding.PaddingAll6,
                            child: CustomImageView(
                              svgPath: ImageConstant.imgCar,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: CustomBottomBar(
                onChanged: (BottomBarEnum type) {
                  Navigator.pushNamed(
                    navigatorKey.currentContext!,
                    getCurrentRoute(type),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
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
