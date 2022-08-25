import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../models/utlility.dart';
import '../../providers/game_provider.dart';

class XOButton extends StatelessWidget {
  final int id;
  const XOButton({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    GameProvider buttonData = Provider.of<GameProvider>(context);
    ButtonType buttonType = buttonData.getButtonType(id);

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
            color: (buttonData.isWinnerButton(id) == true)
                ? winnerBgColor
                : themeData.appBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(15),
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
                child: (buttonData.isWinnerButton(id))
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
                onTap: () => buttonData.onButtonClick(id),
                borderRadius: BorderRadius.circular(15),
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
