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
  final GlobalKey<_MonArroseurScreenState> sprinklerScreenKey =
      GlobalKey<_MonArroseurScreenState>();
  MonArroseurScreen({Key? key}) : super(key: key);
  static WidgetBuilder get builder =>
      (BuildContext context) => MonArroseurScreen();

  @override
  _MonArroseurScreenState createState() => _MonArroseurScreenState();
}

class _MonArroseurScreenState extends State<MonArroseurScreen> {
  Future<List<Sprinkler>>? _sprinklerFuture;
  bool turnOnSprinkler = false;
  bool autoIrrigation = false;
  int? selectedSprinklerId;

  @override
  void initState() {
    super.initState();
    _getMySprinklers();
  }

  void _getMySprinklers() async {
    try {
      setState(() {
        _sprinklerFuture = api.getMySprinklers();
      });
      final sprinklers = await _sprinklerFuture!;
      print('Sprinklers at mon arroseur: $sprinklers');
    } catch (error) {
      setState(() {
        _sprinklerFuture = Future.error('Failed to load sprinklers');
      });
      print('Error while getting sprinklers: $error');
    }
  }

  void refreshPage() {
    _getMySprinklers();
  }

  void _showEditFormModal(
      BuildContext context, List<Sprinkler> sprinklers, int selectedId) {
    Sprinkler selectedSprinkler = sprinklers.firstWhere(
      (sprinkler) => sprinkler.sprinklerId == selectedId,
      orElse: () => Sprinkler(
        sprinklerId: -1,
        userId: -1,
        uniqueCode: '',
        sprinklerName: '',
        location: '',
        waterLevel: 0.0,
        soilMoistureLevel: 0.0,
        temperature: 0.0,
        irrigationStatus: false,
        lastIrrigationTime: null,
        scheduledIrrigationTime: null,
        automaticIrrigation: false,
        createdAt: '',
        updatedAt: '',
      ),
    );

    TextEditingController sprinklerNameController =
        TextEditingController(text: selectedSprinkler.sprinklerName);
    TextEditingController locationController =
        TextEditingController(text: selectedSprinkler.location);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Modifier Arrosoir"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: sprinklerNameController,
                decoration: InputDecoration(
                  labelText: "Nom arrosoir",
                ),
              ),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: "Position",
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String? newName = sprinklerNameController.text.isNotEmpty
                    ? sprinklerNameController.text
                    : null;
                String? newLocation = locationController.text.isNotEmpty
                    ? locationController.text
                    : null;

                _updateSprinkler(selectedId, newName, newLocation);

                Navigator.of(context).pop();
                final _MonArroseurScreenState? sprinklerScreenState =
                    widget.sprinklerScreenKey.currentState;
                if (sprinklerScreenState != null) {
                  sprinklerScreenState
                      .refreshPage(); // Appel de la méthode pour mettre à jour la page de l'arrosoir
                }
              },
              child: Text("Soumettre"),
            ),
          ],
        );
      },
    );
  }

  void _deleteSprinkler(int sprinklerId, BuildContext context) async {
    try {
      await api.deleteSprinkler(sprinklerId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Arrosoir supprimé avec succès.'),
          backgroundColor: Colors.blue,
          duration: const Duration(seconds: 1),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } catch (e) {
      print('Erreur lors de la suppression de l\'arrosoir : $e');
    }
  }

  void _updateSprinkler(
      int sprinklerId, String? sprinklerName, String? location) async {
    try {
      final List<Sprinkler> sprinklers = await _sprinklerFuture!;
      final int updatedSprinklerIndex = sprinklers
          .indexWhere((sprinkler) => sprinkler.sprinklerId == sprinklerId);

      if (updatedSprinklerIndex == -1) {
        print('Arrosoir non trouvé');
        return;
      }

      final String updatedSprinklerName =
          sprinklerName ?? sprinklers[updatedSprinklerIndex].sprinklerName;
      final String updatedSprinklerLocation =
          location ?? sprinklers[updatedSprinklerIndex].location;

      print('Sprinkler ID: $sprinklerId');
      print('Updated Sprinkler Name: $updatedSprinklerName');
      print('Updated Sprinkler Location: $updatedSprinklerLocation');

      await api.updateSprinkler(
        sprinklerId,
        updatedSprinklerName,
        updatedSprinklerLocation,
      );

      // Update only the specific properties of the sprinkler
      if (sprinklerName != null) {
        sprinklers[updatedSprinklerIndex].sprinklerName = updatedSprinklerName;
      }
      if (location != null) {
        sprinklers[updatedSprinklerIndex].location = updatedSprinklerLocation;
      }

      setState(() {
        // No need to update _sprinklerFuture as it's already being used in the FutureBuilder
      });

      Navigator.of(context).pop();
      refreshPage();

      final String requestUrl = "${Utils.baseUrl}/api/sprinklers/$sprinklerId";
      final Map<String, dynamic> requestData = {
        "sprinklerName": updatedSprinklerName,
        "location": updatedSprinklerLocation,
      };

      print('URL de la requête update: $requestUrl');
      print('Données envoyées: $requestData');
      print('Formulaire soumis avec succès');

      // Navigate back to the home page and refresh it
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } catch (e) {
      print('Erreur lors de la mise à jour de l\'arrosoir : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return FutureBuilder<List<Sprinkler>>(
      future: _sprinklerFuture,
      builder: (BuildContext context,
          AsyncSnapshot<List<Sprinkler>> sprinklerSnapshot) {
        if (sprinklerSnapshot.connectionState == ConnectionState.waiting) {
          // If the future is not completed, show a loading indicator
          return Center(child: CircularProgressIndicator());
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
              body: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getVerticalSize(397),
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: double.infinity,
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
                                      padding: getPadding(top: 15, bottom: 15),
                                      child: Text(
                                        '${sprinklers[0].sprinklerName}',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtH1Gray900,
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(top: 5, bottom: 88),
                                      child: Text(
                                        '${sprinklers[0].location}',
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
                              height: getVerticalSize(335),
                              width: getHorizontalSize(285),
                              alignment: Alignment.bottomRight,
                              margin: getMargin(right: 35),
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
                                style: AppStyle.txtParagraphe
                                    .copyWith(fontSize: 15),
                              ),
                            ),
                            Switch(
                              value: turnOnSprinkler,
                              onChanged: (bool value) async {
                                // Note the async keyword here
                                setState(() {
                                  turnOnSprinkler = value;
                                });

                                try {
                                  await api.toggleIrrigation(
                                      sprinklers[0].sprinklerId,
                                      turnOnSprinkler);

                                  final snackBar = SnackBar(
                                    content: Text(value
                                        ? 'Arroseur manuel activé.'
                                        : 'Arroseur manuel désactivé.'),
                                    backgroundColor:
                                        value ? Colors.blue : Colors.orange,
                                    duration: const Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } catch (e) {
                                  print(
                                      'Failed to toggle manual irrigation: $e');
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'Failed to toggle manual irrigation: $e'),
                                    duration: const Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: getVerticalSize(40)),
                      Padding(
                        padding: getPadding(left: 54, right: 53),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: getPadding(top: 5, bottom: 5),
                              child: Text(
                                "Arosage automatique".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtParagraphe
                                    .copyWith(fontSize: 15),
                              ),
                            ),
                            Switch(
                              value: autoIrrigation,
                              onChanged: (bool value) async {
                                setState(() {
                                  autoIrrigation = value;
                                });

                                try {
                                  await api.activateAutomaticIrrigation(
                                    sprinklers[0].sprinklerId,
                                    value, // Pass the switch value to the API method
                                  );

                                  final snackBar = SnackBar(
                                    content: Text(
                                      value
                                          ? 'Arrosage automatique activé.'
                                          : 'Arrosage automatique désactivé.',
                                    ),
                                    backgroundColor:
                                        value ? Colors.blue : Colors.orange,
                                    duration: const Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } catch (e) {
                                  print(
                                      'Failed to activate automatic irrigation: $e');
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'Failed to activate automatic irrigation: $e'),
                                    duration: const Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
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
                              decoration:
                                  AppDecoration.fillBluegray300.copyWith(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding:
                                                getPadding(top: 7, bottom: 6),
                                            child: Text(
                                              '${sprinklers[0].temperature}',
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
                                                  .txtComfortaaRegular36Gray900
                                                  .copyWith(fontSize: 20),
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
                              decoration:
                                  AppDecoration.fillBluegray100.copyWith(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: getPadding(bottom: 9),
                                            child: Text(
                                              '${sprinklers[0].soilMoistureLevel}',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle.txtH1,
                                            ),
                                          ),
                                          Padding(
                                            padding: getPadding(left: 11),
                                            child: Text(
                                              "%".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtComfortaaRegular32Black900
                                                  .copyWith(fontSize: 20),
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
                      // SizedBox(height: getVerticalSize(2)),
                      CustomButton(
                        height: getVerticalSize(39),
                        text: "Modifier Arrosoir".tr,
                        margin: getMargin(left: 49, top: 39, right: 49),
                        variant: ButtonVariant.FillCustomColor,
                        onTap: () {
                          if (sprinklers.isNotEmpty) {
                            _showEditFormModal(
                                context, sprinklers, sprinklers[0].sprinklerId);
                          } else {
                            print("No sprinkler available");
                          }
                        },
                      ),
                      // SizedBox(height: getVerticalSize(5)),
                      CustomButton(
                        height: getVerticalSize(39),
                        text: "Allez sur la Home".tr,
                        margin: getMargin(left: 49, top: 20, right: 49),
                        onTap: () {
                          onTapConfirmerles(context);
                        },
                      ),
                      // SizedBox(height: getVerticalSize(5)),
                      CustomButton(
                        height: getVerticalSize(39),
                        text: "Supprimer Arrosoir".tr,
                        margin: getMargin(left: 49, top: 20, right: 49),
                        variant: ButtonVariant.FillRedAccent,
                        onTap: () {
                          _deleteSprinkler(sprinklers[0].sprinklerId,
                              context); // Remplacez sprinklerId par l'ID de l'arrosoir à supprimer
                        },
                      ),

                      SizedBox(height: getVerticalSize(20)),
                    ],
                  ),
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

/// Navigates to the homeContainerScreen when the action is triggered.
///
/// The [BuildContext] parameter is used to build the navigation stack.
/// When the action is triggered, this function uses the `NavigatorService`
/// to push the named route for the homeContainerScreen.
onTapConfirmerles(BuildContext context) {
  NavigatorService.pushNamed(
    AppRoutes.homePage,
  );
}
