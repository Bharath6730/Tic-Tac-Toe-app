import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/models/xo_button_class.dart';
import 'package:tic_tac_toe/providers/game_provider.dart';

class XOButton extends StatelessWidget {
  final int id;
  const XOButton({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    final shadowColor = themeData.appBarTheme.shadowColor as Color;

    GameProvider buttonData = Provider.of<GameProvider>(context);
    ButtonType buttonType = buttonData.getButtonType(id);

    String assetLink = buttonData.getAssetLink(id);

    Color winnerBgColor;
    Color winnerSvgColor;
    if (buttonType == ButtonType.X) {
      winnerBgColor = const Color(0xff31c3bd);
    } else {
      winnerBgColor = const Color(0xfff2b137);
    }
    winnerSvgColor = themeData.appBarTheme.backgroundColor as Color;

    return Container(
        decoration: BoxDecoration(
            color: (buttonData.isWinnerButton(id) == true)
                ? winnerBgColor
                : themeData.appBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 2,
                spreadRadius: 2,
              )
            ]),
        alignment: Alignment.center,
        child: Stack(
          children: [
            if (assetLink != "")
              Positioned(
                left: 25,
                top: 25,
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
