import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/widgets/dialogs/custom_dialog.dart';
import '../../utilities/utlility.dart';

class WinnerDialog extends StatelessWidget {
  final VoidCallback resetGame;
  final VoidCallback returnFunction;
  final WinnerType winner;
  final String winnerText;

  const WinnerDialog({
    Key? key,
    required this.resetGame,
    required this.returnFunction,
    required this.winner,
    required this.winnerText,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    Color winColor;
    bool itsADraw = false;

    if (winner != WinnerType.draw) {
      winColor = (winner == WinnerType.X)
          ? AppTheme.xbuttonColor
          : AppTheme.oButtonColor;
    } else {
      itsADraw = true;
      winColor = Colors.red;
    }

    return CustomDialog(
        headerTitle: (!itsADraw) ? winnerText : "ITS A TIE!",
        leftButtonTitle: "QUIT",
        onLeftButtonPress: returnFunction,
        rightButtonTitle: "NEXT ROUND",
        onRightButtonPress: (() {
          Navigator.of(context).pop();
          resetGame();
        }),
        body: showWinnerText(
            itsADraw: itsADraw, winColor: winColor, winner: winner));
  }
}

Widget showWinnerText(
    {required bool itsADraw,
    required Color winColor,
    required WinnerType winner}) {
  return (!itsADraw)
      ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(
            getAssetLink(winner == WinnerType.X ? ButtonType.X : ButtonType.O),
            height: 28,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            "TAKES THE ROUND",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w700, color: winColor),
            textAlign: TextAlign.center,
          ),
        ])
      : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              getAssetLink(ButtonType.O),
              height: 30,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              "-",
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w700, color: winColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              width: 12,
            ),
            SvgPicture.asset(
              getAssetLink(ButtonType.X),
              height: 30,
            ),
          ],
        );
}
