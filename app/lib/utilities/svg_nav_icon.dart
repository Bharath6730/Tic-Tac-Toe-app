import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarSvgIcon extends StatelessWidget {
  final int selectedOption;
  final String asset;
  final int iconNumber;

  const NavBarSvgIcon(
      {Key? key,
      required this.selectedOption,
      required this.iconNumber,
      required this.asset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: 30,
      height: 25,
      color: selectedOption == iconNumber ? Colors.white : Colors.grey,
    );
  }
}
