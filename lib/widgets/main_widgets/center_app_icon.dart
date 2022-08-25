import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tic_tac_toe/models/utlility.dart';

class CenterAppIcon extends StatelessWidget {
  const CenterAppIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Row(
        children: [
          SvgPicture.asset(getAssetLink(ButtonType.X), height: 25),
          const SizedBox(
            width: 4,
          ),
          SvgPicture.asset(
            getAssetLink(ButtonType.O),
            height: 25,
          ),
        ],
      ),
    );
  }
}
