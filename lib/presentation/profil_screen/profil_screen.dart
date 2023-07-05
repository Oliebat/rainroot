import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rainroot/core/app_export.dart';
import 'package:rainroot/core/constants/utils.dart';
import 'package:rainroot/core/utils/validation_functions.dart';
import 'package:rainroot/data/apiClient/api_client.dart' as api;
import 'package:rainroot/presentation/home_page/home_page.dart';
import 'package:rainroot/widgets/custom_bottom_bar.dart';
import 'package:rainroot/widgets/custom_button.dart';
import 'package:rainroot/widgets/custom_icon_button.dart';
import 'package:rainroot/widgets/custom_image_view.dart';
import 'package:rainroot/widgets/custom_text_form_field.dart';
import 'package:rainroot/presentation/starter_screen/starter_screen.dart';

import 'dart:async';

class ProfilScreen extends StatefulWidget {
  ProfilScreen({Key? key}) : super(key: key);

  static WidgetBuilder get builder => (BuildContext context) => ProfilScreen();

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = FlutterSecureStorage();
  bool fieldsEmptyError = false;
  String? errorMsg;
  Future<User>? _userFuture;

  User? user; // Newly added User object

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    // Get user id from UserManager
    String? userId = await UserManager().getUserId();
    print('UserId: $userId');

    if (userId != null) {
      // Get user data from API
      _userFuture = api.getUserById(userId);
      _userFuture!.then((user) {
        print('User at profil: $user'); // Print the user object

        // Print user details
        print('First Name: ${user.firstName}');
        print('Last Name: ${user.lastName}');
        print('Email: ${user.email}');

        // Get user picture URL
        String? picture = user.picture;
        print('User Picture: $picture');

        // Update the text field with user information and save the user object
        setState(() {
          _firstNameController.text = user.firstName ?? "";
          _nameController.text = user.lastName ?? "";
          _emailController.text = user.email ?? "";
          _passwordController.text = '';

          // Save the user object
          this.user = user;
        });
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

  void _deleteUser(int? userId, BuildContext context) async {
    if (userId != null) {
      try {
        await api.deleteUser(userId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Compte supprimé avec succès.'),
            backgroundColor: Colors.blue,
            duration: const Duration(seconds: 1),
          ),
        );

        final storage = new FlutterSecureStorage();
        await storage.deleteAll();

        Navigator.pushReplacementNamed(context, AppRoutes.starterScreen);
      } catch (e) {
        print('Erreur lors de la suppression du compte : $e');
      }
    } else {
      print('Erreur : userId est null.');
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation de suppression"),
          content: Text(
              "Êtes-vous sûr de vouloir supprimer votre compte ? Cette action est définitive."),
          actions: [
            TextButton(
              child: Text("Non"),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
            ),
            TextButton(
              child: Text("Oui"),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
                _deleteUser(user?.id, context); // Supprimez l'utilisateur
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteA700,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 17, 20, 17),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageConstant.imgGroup6),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButton(
                        height: 48,
                        width: 48,
                        margin: EdgeInsets.only(top: 2),
                        shape: IconButtonShape.CircleBorder24,
                        onTap: () {
                          onTapBtnArrowleft(context);
                        },
                        child: CustomImageView(
                          svgPath: ImageConstant.imgArrowleft,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 106,
                          width: 136,
                          margin: EdgeInsets.only(top: 28),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              CustomImageView(
                                url: user?.picture ?? '',
                                height: 106,
                                width: 106,
                                radius: BorderRadius.circular(50),
                                alignment: Alignment.centerLeft,
                              ),
                              CustomIconButton(
                                height: 48,
                                width: 48,
                                variant: IconButtonVariant.OutlineBlack90033_1,
                                padding: IconButtonPadding.PaddingAll6,
                                alignment: Alignment.centerRight,
                                child: CustomImageView(
                                  svgPath: ImageConstant.imgCamera,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 14),
                child: Text(
                  'Bonjour, ${user?.firstName ?? ''}'.tr,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtH1Gray900,
                ),
              ),
              SizedBox(height: getVerticalSize(70)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    CustomTextFormField(
                      controller: _firstNameController,
                      hintText: "Prénom".tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre prénom';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40),
                    CustomTextFormField(
                      controller: _nameController,
                      hintText: "Nom".tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40),
                    CustomTextFormField(
                      controller: _emailController,
                      hintText: "Email".tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre adresse e-mail';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40),
                    CustomTextFormField(
                      controller: _passwordController,
                      hintText: "Mot de passe".tr,
                      isObscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre mot de passe';
                        }
                        return null;
                      },
                    ),
                    CustomButton(
                      height: 39,
                      text: "Mettre à jour".tr,
                      margin: EdgeInsets.only(top: 52, bottom: 30),
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          var firstName = _firstNameController.text;
                          var lastName = _nameController.text;
                          var email = _emailController.text;
                          var password = _passwordController.text;

                          if (email.isEmpty ||
                              password.isEmpty ||
                              firstName.isEmpty ||
                              lastName.isEmpty) {
                            setState(() {
                              fieldsEmptyError = true;
                            });
                          } else {
                            setState(() {
                              fieldsEmptyError = false;
                            });
                            try {
                              var data = await api.updateUser(
                                firstName,
                                lastName,
                                email,
                                password,
                              );

                              print('Data from updateUser: $data');

                              if (data.containsKey('message') &&
                                  data['message'] ==
                                      'User updated successfully!') {
                                showSnackbar('Modification du compte réussie');
                                NavigatorService.pushNamed(AppRoutes.homePage);
                              } else if (data.containsKey('error')) {
                                showSnackbar(data[
                                    'error']); // Afficher le message d'erreur renvoyé par le serveur
                              } else {
                                showSnackbar(
                                    'Échec de la modification du compte');
                              }
                            } catch (e) {
                              showSnackbar(
                                  'Une erreur inattendue est survenue');
                              print('Error during account update: $e');
                            }
                          }
                        }
                      },
                    ),
                    CustomButton(
                      height: getVerticalSize(39),
                      text: "Supprimer Arrosoir".tr,
                      margin: getMargin(left: 49, top: 20, right: 49),
                      variant: ButtonVariant.FillRedAccent,
                      onTap: () {
                        _showDeleteConfirmationDialog(
                            context); // Affiche la boîte de dialogue modale de confirmation
                      },
                    ),
                  ],
                ),
              )
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
    );
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

  Widget getCurrentPage(BuildContext context, String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage.builder(context);
      default:
        return DefaultWidget();
    }
  }

  onTapBtnArrowleft(BuildContext context) {
    NavigatorService.goBack();
  }

  onTapConfirmerles(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.homeContainerScreen,
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
