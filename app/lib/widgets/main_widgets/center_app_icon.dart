import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';

class CenterAppIcon extends StatelessWidget {
  final double height;
  const CenterAppIcon({Key? key, this.height = 25}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: XOIcon(height: height),
    );
  }
}

class XOIcon extends StatelessWidget {
  const XOIcon({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(getAssetLink(ButtonType.X), height: height),
        const SizedBox(
          width: 4,
        ),
        SvgPicture.asset(
          getAssetLink(ButtonType.O),
          height: height,
        ),
      ],
    );
  }
}
