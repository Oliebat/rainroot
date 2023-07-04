import 'package:flutter/material.dart';
import 'package:rainroot/core/app_export.dart';
import 'package:rainroot/presentation/home_page/home_page.dart';
import 'package:rainroot/widgets/custom_bottom_bar.dart';
import 'package:rainroot/widgets/custom_icon_button.dart';
import 'package:rainroot/data/apiClient/api_client.dart' as api;
import 'package:rainroot/core/constants/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ArroseursScreen extends StatefulWidget {
  ArroseursScreen({Key? key}) : super(key: key);

  static WidgetBuilder get builder =>
      (BuildContext context) => ArroseursScreen();

  @override
  _ArroseursScreenState createState() => _ArroseursScreenState();
}

class _ArroseursScreenState extends State<ArroseursScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _location = '';
  String _code = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _showAddSprinklerDialog() async {
    final TextEditingController sprinklerNameController =
        TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController uniqueCodeController = TextEditingController();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a new Sprinkler'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: uniqueCodeController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Unique Code',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a unique code';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: sprinklerNameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Sprinkler Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Sprinkler Location',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a location';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  String uniqueCode = uniqueCodeController.text;
                  String sprinklerName = sprinklerNameController.text;
                  String location = locationController.text;

                  final storage = FlutterSecureStorage();
                  storage.read(key: 'UserId').then((userId) {
                    if (userId != null) {
                      api
                          .createSprinkler(
                              uniqueCode, sprinklerName, location, userId)
                          .then((response) {
                        if (response.containsKey('error')) {
                          showSnackBar(
                              'Erreur lors de la création de l\'arrosoir',
                              Colors.red);
                        } else {
                          showSnackBar(
                              'Arrosoir ajouté avec succès', Colors.green);
                          refreshPage();
                        }
                      });
                    } else {
                      print('Error: User ID not found');
                    }
                  });

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: backgroundColor,
      ),
    );
  }

  void refreshPage() {
    // Refresh the page here
    setState(() {
      // Add any necessary logic to refresh the page
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sprinkler>>(
      future: api.getMySprinklers(),
      builder: (BuildContext context, AsyncSnapshot<List<Sprinkler>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else {
          var sprinklers = snapshot.data ?? [];
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: ColorConstant.whiteA700,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: getVerticalSize(254),
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
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
                                    padding: getPadding(top: 15, bottom: 89),
                                    child: Text(
                                      "lbl_mes_robots".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtH1Gray900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: getHorizontalSize(321),
                              child: Text(
                                "msg_ajoutez_et_de_configurez".tr,
                                maxLines: null,
                                textAlign: TextAlign.center,
                                style: AppStyle.txtParagraphe
                                    .copyWith(fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getVerticalSize(30)),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: CustomIconButton(
                        height: 48,
                        width: 48,
                        shape: IconButtonShape.CircleBorder24,
                        onTap: () {
                          _showAddSprinklerDialog();
                        },
                        child: CustomImageView(
                          svgPath: ImageConstant.imgPlus,
                        ),
                      ),
                    ),
                    SizedBox(height: getVerticalSize(40)),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: getPadding(all: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: getVerticalSize(
                                    500), // Ajustez la hauteur en fonction de vos besoins
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: sprinklers.map((sprinkler) {
                                    return Container(
                                      margin: EdgeInsets.all(10),
                                      padding: getPadding(all: 10),
                                      decoration: AppDecoration
                                          .outlineBlack900331
                                          .copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder20,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Card(
                                            clipBehavior: Clip.antiAlias,
                                            elevation: 0,
                                            margin: EdgeInsets.all(0),
                                            color: ColorConstant.whiteA700,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder20,
                                            ),
                                            child: Container(
                                              height: getVerticalSize(133),
                                              width: getHorizontalSize(161),
                                              padding: getPadding(
                                                left: 46,
                                                top: 28,
                                                right: 46,
                                                bottom: 28,
                                              ),
                                              decoration: AppDecoration
                                                  .fillWhiteA700
                                                  .copyWith(
                                                borderRadius: BorderRadiusStyle
                                                    .roundedBorder20,
                                              ),
                                              child: Stack(
                                                children: [
                                                  CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgUserBlueGray700,
                                                    height: getVerticalSize(76),
                                                    width:
                                                        getHorizontalSize(67),
                                                    alignment: Alignment.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                getPadding(top: 18, bottom: 9),
                                            child: Text(
                                              '${sprinkler.sprinklerName}',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle.txtH2Black900,
                                            ),
                                          ),
                                          Text(
                                            '${sprinkler.location}',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtH2Black900,
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
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
