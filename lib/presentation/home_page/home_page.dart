import 'bloc/home_bloc.dart';
import 'models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:rainroot/core/app_export.dart';
import 'package:rainroot/widgets/app_bar/custom_app_bar.dart';
import 'package:rainroot/widgets/custom_bottom_bar.dart';
import 'package:rainroot/core/constants/utils.dart';
import 'package:rainroot/data/apiClient/api_client.dart' as api;
import 'dart:async';
// path arrroseurs_screen
import 'package:rainroot/presentation/mon_arroseur_screen/mon_arroseur_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static WidgetBuilder get builder => (BuildContext context) => HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasSprinklers = false;
  Future<User>? _userFuture = Completer<User>().future;
  Future<List<Sprinkler>>? _sprinklerFuture =
      Completer<List<Sprinkler>>().future;

  @override
  @override
  void initState() {
    super.initState();
    _getUser();
    _getMySprinklers();
  }

  void navigateToMonArroseurScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MonArroseurScreen(),
      ),
    );

    refreshPage(); // Appeler refreshPage après le retour de MonArroseurScreen
  }

  void refreshPage() {
    setState(() {
      _userFuture = Completer<User>().future;
      _sprinklerFuture = Completer<List<Sprinkler>>().future;
    });
    _getUser();
    _getMySprinklers();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    refreshPage(); // Mettre à jour la page d'accueil
  }

  void _getUser() async {
    // Get user id from UserManager
    String? userId = await UserManager().getUserId();
    print('UserId: $userId');

    if (userId != null) {
      // Get user data from API
      setState(() {
        _userFuture = api.getUserById(userId);
      });
      _userFuture!.then((user) {
        print('User at homepage: $user'); // Print the user object
      }).catchError((error) {
        setState(() {
          _userFuture = Future.error(error);
        });
      });
    } else {
      // If the user id is null, show an error
      setState(() {
        _userFuture = Future.error('User id is null');
      });
    }
  }

  void _getMySprinklers() async {
    // Get sprinklers data from API
    setState(() {
      _sprinklerFuture = api.getMySprinklers();
    });
    _sprinklerFuture!.then((sprinklers) {
      setState(() {
        hasSprinklers = sprinklers.isNotEmpty;
      });
      print(
          'Sprinklers at homepage: $sprinklers'); // Print the sprinkler objects
    }).catchError((error) {
      // If an error occurred while getting sprinklers data, show an error
      setState(() {
        _sprinklerFuture = Future.error('Failed to load sprinklers');
      });
    });
  }

  void onTapMesplantes(BuildContext context) {
    if (hasSprinklers) {
      NavigatorService.pushNamed(AppRoutes.monArroseurScreen);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pas d\'arroseur associé'),
          // snackbar red
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return FutureBuilder<List<dynamic>>(
      // Call the API to get the user and sprinkler data
      future: Future.wait<dynamic>([
        _userFuture as Future<dynamic>,
        _sprinklerFuture as Future<dynamic>
      ]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the future is not completed, show a loading indicator
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If the future completed with an error, display it
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          // If the future completed but there's no data, display a message
          return Text('No data available');
        } else {
          // The future has been completed, use the data
          User user = snapshot.data![0] as User;
          List<Sprinkler> sprinklers = snapshot.data![1] as List<Sprinkler>;
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorConstant.whiteA700,
              body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.fillWhiteA700,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: getVerticalSize(145),
                      width: getHorizontalSize(388),
                      margin: getMargin(top: 46),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgRectangle3,
                            height: getVerticalSize(145),
                            width: getHorizontalSize(388),
                            radius:
                                BorderRadius.circular(getHorizontalSize(20)),
                            alignment: Alignment.center,
                          ),
                          CustomAppBar(
                            height: getVerticalSize(106),
                            centerTitle: true,
                            title: Row(
                              children: [
                                CustomImageView(
                                  url: user.picture,
                                  margin:
                                      getMargin(left: 30, top: 0, bottom: 0),
                                  width: getSize(106),
                                  radius: BorderRadius.circular(
                                      getHorizontalSize(50)),
                                ),
                                Padding(
                                  padding:
                                      getPadding(left: 25, top: 40, bottom: 38),
                                  child: Text(
                                    "Bonjour ${user.firstName}",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtH1WhiteA700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          getPadding(left: 19, top: 29, right: 19, bottom: 29),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "lbl_tableau_de_bord".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtComfortaaBold24,
                          ),
                          Container(
                            height: getVerticalSize(529),
                            width: getHorizontalSize(388),
                            margin: getMargin(top: 30),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                CustomImageView(
                                  svgPath: ImageConstant.imgLogoetats,
                                  height: getVerticalSize(404),
                                  width: getHorizontalSize(338),
                                  alignment: Alignment.topCenter,
                                  margin: getMargin(top: 29),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    padding: getPadding(
                                        left: 16,
                                        top: 14,
                                        right: 16,
                                        bottom: 14),
                                    decoration: AppDecoration.outlineBlack9003f
                                        .copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder20,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "lbl_conseil_du_jour".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtH2WhiteA700,
                                        ),
                                        Padding(
                                          padding:
                                              getPadding(top: 4, right: 11),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "lbl_14".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style:
                                                    AppStyle.txtComfortaaBold96,
                                              ),
                                              CustomImageView(
                                                svgPath: ImageConstant.imgClock,
                                                height: getVerticalSize(83),
                                                width: getHorizontalSize(72),
                                                margin: getMargin(
                                                    top: 10, bottom: 14),
                                              ),
                                              Container(
                                                width: getHorizontalSize(137),
                                                margin: getMargin(
                                                    top: 19, bottom: 31),
                                                child: Text(
                                                  "msg_n_oubliez_pas_d_arroser"
                                                      .tr,
                                                  maxLines: null,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtParagrapheWhiteA700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                onTapMesplantes(context);
                                              },
                                              child: Container(
                                                margin:
                                                    getMargin(top: 1, right: 8),
                                                padding: getPadding(
                                                    left: 9,
                                                    top: 12,
                                                    right: 9,
                                                    bottom: 12),
                                                decoration: AppDecoration
                                                    .outlineBlack9003f1
                                                    .copyWith(
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder20,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      hasSprinklers
                                                          ? '${sprinklers[0].sprinklerName}'
                                                          : "",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle.txtH2,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        height: getVerticalSize(
                                                            150),
                                                        width:
                                                            getHorizontalSize(
                                                                116),
                                                        margin: getMargin(
                                                            top: 28,
                                                            bottom: 17),
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              child: Container(
                                                                height:
                                                                    getVerticalSize(
                                                                        107),
                                                                width:
                                                                    getHorizontalSize(
                                                                        108),
                                                                margin:
                                                                    getMargin(
                                                                        top:
                                                                            14),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      ColorConstant
                                                                          .red50,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              getHorizontalSize(54)),
                                                                ),
                                                              ),
                                                            ),
                                                            CustomImageView(
                                                              imagePath:
                                                                  ImageConstant
                                                                      .img3dcasuallife150x116,
                                                              height:
                                                                  getVerticalSize(
                                                                      150),
                                                              width:
                                                                  getHorizontalSize(
                                                                      116),
                                                              radius: BorderRadius
                                                                  .circular(
                                                                      getHorizontalSize(
                                                                          25)),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
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
                                          Expanded(
                                            child: Padding(
                                              padding: getPadding(
                                                  left: 8, bottom: 1),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        getHorizontalSize(186),
                                                    padding: getPadding(
                                                        left: 12,
                                                        top: 6,
                                                        right: 12,
                                                        bottom: 6),
                                                    decoration: AppDecoration
                                                        .fillBluegray300
                                                        .copyWith(
                                                      borderRadius:
                                                          BorderRadiusStyle
                                                              .roundedBorder20,
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width:
                                                              getHorizontalSize(
                                                                  99),
                                                          margin:
                                                              getMargin(top: 4),
                                                          child: Text(
                                                            "msg_temp_rature_interieure"
                                                                .tr,
                                                            maxLines: null,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                AppStyle.txtH2,
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Padding(
                                                            padding: getPadding(
                                                                top: 1,
                                                                right: 13),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      getPadding(
                                                                          top:
                                                                              18),
                                                                  child: Text(
                                                                    hasSprinklers
                                                                        ? '${sprinklers[0].temperature}'
                                                                        : "...",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: AppStyle
                                                                        .txtComfortaaRegular32
                                                                        .copyWith(
                                                                            fontSize:
                                                                                20),
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible:
                                                                      hasSprinklers,
                                                                  child:
                                                                      Padding(
                                                                    padding: getPadding(
                                                                        left:
                                                                            15),
                                                                    child: Text(
                                                                      "lbl_c"
                                                                          .tr,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: AppStyle
                                                                          .txtComfortaaRegular48
                                                                          .copyWith(
                                                                              fontSize: 20),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        getHorizontalSize(186),
                                                    margin: getMargin(top: 16),
                                                    padding: getPadding(
                                                        left: 12,
                                                        top: 11,
                                                        right: 12,
                                                        bottom: 11),
                                                    decoration: AppDecoration
                                                        .fillBluegray700
                                                        .copyWith(
                                                      borderRadius:
                                                          BorderRadiusStyle
                                                              .roundedBorder20,
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "lbl_humidit".tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtH2WhiteA700,
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Padding(
                                                            padding: getPadding(
                                                                top: 26,
                                                                bottom: 2),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      getPadding(
                                                                          bottom:
                                                                              4),
                                                                  child: Text(
                                                                    hasSprinklers
                                                                        ? '${sprinklers[0].soilMoistureLevel}'
                                                                        : "...",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: AppStyle
                                                                        .txtComfortaaRegular32WhiteA700,
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible:
                                                                      hasSprinklers,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        getPadding(
                                                                            left:
                                                                                9),
                                                                    child: Text(
                                                                      "lbl_g_m3"
                                                                          .tr,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: AppStyle
                                                                          .txtComfortaaRegular48
                                                                          .copyWith(
                                                                              fontSize: 20),
                                                                    ),
                                                                  ),
                                                                )
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
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: getPadding(left: 3, top: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: getMargin(right: 11),
                                                padding: getPadding(
                                                    left: 14,
                                                    top: 6,
                                                    right: 14,
                                                    bottom: 6),
                                                decoration: AppDecoration
                                                    .fillBluegray300
                                                    .copyWith(
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder20,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "lbl_captures".tr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle.txtH2,
                                                    ),
                                                    CustomImageView(
                                                      svgPath: ImageConstant
                                                          .imgIcones,
                                                      height: getSize(50),
                                                      width: getSize(50),
                                                      radius:
                                                          BorderRadius.circular(
                                                              getHorizontalSize(
                                                                  6)),
                                                      alignment:
                                                          Alignment.center,
                                                      margin: getMargin(
                                                          top: 9, bottom: 4),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: getMargin(
                                                    left: 11,
                                                    right: 11,
                                                    bottom: 1),
                                                padding: getPadding(
                                                    left: 14,
                                                    top: 4,
                                                    right: 14,
                                                    bottom: 4),
                                                decoration: AppDecoration
                                                    .fillBluegray700
                                                    .copyWith(
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder20,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "lbl_d_couvrir".tr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtH2WhiteA700,
                                                    ),
                                                    CustomImageView(
                                                      svgPath: ImageConstant
                                                          .imgIconesWhiteA700,
                                                      height: getSize(50),
                                                      width: getSize(50),
                                                      radius:
                                                          BorderRadius.circular(
                                                              getHorizontalSize(
                                                                  6)),
                                                      alignment:
                                                          Alignment.center,
                                                      margin: getMargin(
                                                          top: 7, bottom: 9),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  onTapColumnajouter(context);
                                                },
                                                child: Container(
                                                  margin: getMargin(
                                                      left: 11, bottom: 1),
                                                  padding: getPadding(
                                                      left: 13,
                                                      top: 6,
                                                      right: 13,
                                                      bottom: 6),
                                                  decoration: AppDecoration
                                                      .fillDeeporange100
                                                      .copyWith(
                                                    borderRadius:
                                                        BorderRadiusStyle
                                                            .roundedBorder20,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "lbl_ajouter".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle.txtH2,
                                                      ),
                                                      CustomImageView(
                                                        svgPath: ImageConstant
                                                            .imgIconesWhiteA70050x50,
                                                        height: getSize(50),
                                                        width: getSize(50),
                                                        radius: BorderRadius
                                                            .circular(
                                                                getHorizontalSize(
                                                                    25)),
                                                        alignment:
                                                            Alignment.center,
                                                        margin: getMargin(
                                                            top: 5, bottom: 7),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                  Navigator.of(context).pushNamed(
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

/// Navigates to the arroseursScreen when the action is triggered.
///
/// The [BuildContext] parameter is used to build the navigation stack.
/// When the action is triggered, this function uses the `NavigatorService`
/// to push the named route for the arroseursScreen.
// onTapMesplantes(BuildContext context) {
//   if (hasSprinklers) {
//     NavigatorService.pushNamed(AppRoutes.monArroseurScreen);
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Pas d\'arroseur associé'),
//       ),
//     );
//   }
// }
/// Navigates to the arroseursScreen when the action is triggered.
///
/// The [BuildContext] parameter is used to build the navigation stack.
/// When the action is triggered, this function uses the `NavigatorService`
/// to push the named route for the arroseursScreen.
onTapColumnajouter(BuildContext context) {
  NavigatorService.pushNamed(
    AppRoutes.arroseursScreen,
  );
}
