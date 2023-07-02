import 'package:flutter/material.dart';
import 'package:rainroot/core/app_export.dart';
import 'package:rainroot/core/constants/utils.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  final Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;
  late int logoutIndex;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: Icons.home,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: Icons.person,
      type: BottomBarEnum.Profil,
    ),
    BottomMenuModel(
      icon: Icons.shower,
      type: BottomBarEnum.Arrosoir,
    ),
    BottomMenuModel(
      icon: Icons.logout,
      type: BottomBarEnum.Logout,
    ),
  ];

  @override
  void initState() {
    super.initState();
    logoutIndex =
        bottomMenuList.indexWhere((item) => item.type == BottomBarEnum.Logout);
  }

  void logout() {
    TokenUtils.setToken('');
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.connexionScreen,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black90033,
            spreadRadius: getHorizontalSize(2),
            blurRadius: getHorizontalSize(2),
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: Icon(bottomMenuList[index].icon),
            label: '',
          );
        }),
        onTap: (index) {
          if (index == logoutIndex) {
            logout();
          } else {
            selectedIndex = index;
            widget.onChanged?.call(bottomMenuList[index].type);
            setState(() {
              if (bottomMenuList[index].type == BottomBarEnum.Home) {
                Navigator.pushNamed(context, AppRoutes.homePage);
              } else if (bottomMenuList[index].type == BottomBarEnum.Profil) {
                Navigator.pushNamed(context, AppRoutes.profilScreen);
              } else if (bottomMenuList[index].type == BottomBarEnum.Arrosoir) {
                Navigator.pushNamed(context, AppRoutes.arroseursScreen);
              }
            });
          }
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Home,
  Profil,
  Arrosoir,
  Logout,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.type,
  });

  IconData icon;
  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
