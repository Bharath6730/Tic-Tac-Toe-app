import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/svg_nav_icon.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';


class BottomNavBar extends StatelessWidget {
  final int selectedOption;
  final Function onTap;
  const BottomNavBar(
      {Key? key, required this.selectedOption, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: AppTheme.dialogColor,
        currentIndex: selectedOption,
        showUnselectedLabels: false,
        unselectedIconTheme:
            IconThemeData(color: Colors.grey.withOpacity(0.5), size: 25),
        selectedIconTheme:
            IconThemeData(color: Colors.white.withOpacity(0.8), size: 25),
        showSelectedLabels: false,
        onTap: (value) {
          onTap(value);
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: NavBarSvgIcon(
                selectedOption: selectedOption,
                iconNumber: 1,
                asset: "assets/svg/homepage/friends.svg",
              ),
              label: "Friends"),
          BottomNavigationBarItem(
              icon: NavBarSvgIcon(
                selectedOption: selectedOption,
                iconNumber: 2,
                asset: "assets/svg/homepage/profile.svg",
              ),
              label: "Settings"),
        ]);
  }
}