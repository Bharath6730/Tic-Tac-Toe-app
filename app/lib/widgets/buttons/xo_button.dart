import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import '../../models/xo_button_class.dart';

import '../../utilities/utlility.dart';

class XOButton extends StatelessWidget {
  final int id;
  final Function onButtonClick;
  const XOButton({Key? key, required this.id, required this.onButtonClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    XOButtonProvider buttonData = Provider.of<XOButtonProvider>(context);
    ButtonType buttonType = buttonData.buttontype;

    String assetLink = getAssetLink(buttonType);

    Color winnerBgColor;
    Color winnerSvgColor;
    if (buttonType == ButtonType.X) {
      winnerBgColor = AppTheme.xbuttonColor;
    } else {
      winnerBgColor = AppTheme.oButtonColor;
    }
    winnerSvgColor = themeData.appBarTheme.backgroundColor as Color;

    return Container(
        margin: const EdgeInsets.only(bottom: 3),
        decoration: BoxDecoration(
            color: (buttonData.isWinnerButton == true)
                ? winnerBgColor
                : themeData.appBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: AppTheme.darkShadow,
                offset: Offset(0, 3),
                blurRadius: 2,
              ),
            ]),
        alignment: Alignment.center,
        child: Stack(
          children: [
            if (assetLink != "")
              Center(
                child: (buttonData.isWinnerButton)
                    ? SvgPicture.asset(
                        assetLink,
                        color: winnerSvgColor,
                      )
                    : SvgPicture.asset(
                        assetLink,
                      ),
              ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onButtonClick(id),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
