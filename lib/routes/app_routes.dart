import 'package:flutter/material.dart';
import 'package:rainroot/presentation/page_connexion_screen/page_connexion_screen.dart';
import 'package:rainroot/presentation/splash_screen/splash_screen.dart';
import 'package:rainroot/presentation/starter_screen/starter_screen.dart';
import 'package:rainroot/presentation/creation_compte_screen/creation_compte_screen.dart';
import 'package:rainroot/presentation/connexion_screen/connexion_screen.dart';
import 'package:rainroot/presentation/reset_screen/reset_screen.dart';
import 'package:rainroot/presentation/home_container_screen/home_container_screen.dart';
import 'package:rainroot/presentation/profil_screen/profil_screen.dart';
import 'package:rainroot/presentation/arroseurs_screen/arroseurs_screen.dart';
import 'package:rainroot/presentation/mon_arroseur_screen/mon_arroseur_screen.dart';
import 'package:rainroot/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:rainroot/presentation/home_page/home_page.dart';

class AppRoutes {
  static const String pageConnexionScreen = '/page_connexion_screen';

  static const String splashScreen = '/splash_screen';

  static const String starterScreen = '/starter_screen';

  static const String creationCompteScreen = '/creation_compte_screen';

  static const String connexionScreen = '/connexion_screen';

  static const String resetScreen = '/reset_screen';

  static const String homePage = '/home_page';

  static const String homeContainerScreen = '/home_container_screen';

  static const String profilScreen = '/profil_screen';

  static const String arroseursScreen = '/arroseurs_screen';

  static const String monArroseurScreen = '/mon_arroseur_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
        pageConnexionScreen: PageConnexionScreen.builder,
        splashScreen: SplashScreen.builder,
        starterScreen: StarterScreen.builder,
        creationCompteScreen: CreationCompteScreen.builder,
        connexionScreen: ConnexionScreen.builder,
        resetScreen: ResetScreen.builder,
        // homeContainerScreen: HomeContainerScreen.builder,
        // passe le userId en parametre pour la home page
        homePage: HomePage.builder,
        profilScreen: ProfilScreen.builder,
        arroseursScreen: ArroseursScreen.builder,
        monArroseurScreen: MonArroseurScreen.builder,
        appNavigationScreen: AppNavigationScreen.builder,
        initialRoute: SplashScreen.builder
      };
}
