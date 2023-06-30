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

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgIconesWhiteA70048x48,
      type: BottomBarEnum.Iconeswhitea70048x48,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgIconesWhiteA70048x48,
      type: BottomBarEnum.Iconeswhitea70048x48,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgIconesWhiteA70048x48,
      type: BottomBarEnum.Iconeswhitea70048x48,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgIconesWhiteA70048x48,
      type: BottomBarEnum.Logout,
    ),
  ];

  void logout() {
    TokenUtils.setToken(
        ''); // Supprimer le token en le définissant comme une chaîne vide
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
          if (bottomMenuList[index].type == BottomBarEnum.Logout) {
            return BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.logout),
                onPressed: logout,
              ),
              label: '',
            );
          } else {
            return BottomNavigationBarItem(
              icon: CustomImageView(
                svgPath: bottomMenuList[index].icon,
                height: getSize(48),
                width: getSize(48),
                color: ColorConstant.whiteA700,
                radius: BorderRadius.circular(getHorizontalSize(6)),
              ),
              activeIcon: CustomImageView(
                svgPath: bottomMenuList[index].icon,
                height: getSize(48),
                width: getSize(48),
                color: ColorConstant.whiteA700,
                radius: BorderRadius.circular(getHorizontalSize(6)),
              ),
              label: '',
            );
          }
        }),
        onTap: (index) {
          if (bottomMenuList[index].type != BottomBarEnum.Logout) {
            selectedIndex = index;
            widget.onChanged?.call(bottomMenuList[index].type);
            setState(() {});
          }
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Iconeswhitea70048x48,
  Logout,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.type,
  });

  String icon;
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
