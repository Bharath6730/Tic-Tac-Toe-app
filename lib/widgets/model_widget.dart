import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/utlility.dart';
import 'buttons/submit_button.dart';

class ModelWidget extends StatelessWidget {
  final VoidCallback resetGame;
  final ButtonType winner;
  final String winnerText;

  const ModelWidget(
      {Key? key,
      required this.resetGame,
      required this.winner,
      required this.winnerText})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    Color winColor;
    bool itsADraw = false;

    if (winner != ButtonType.none) {
      winColor = (winner == ButtonType.X)
          ? AppTheme.xbuttonColor
          : AppTheme.oButtonColor;
    } else {
      itsADraw = true;
      winColor = Colors.red;
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).appBarTheme.backgroundColor),
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(children: [
          Text((!itsADraw) ? winnerText : "ITS A TIE!",
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center),
          const SizedBox(
            height: 25,
          ),
          (!itsADraw)
              ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SvgPicture.asset(
                    getAssetLink(winner),
                    height: 28,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "TAKES THE ROUND",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: winColor),
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
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: winColor),
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
                ),
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SubmitButton(
                backgroundColor: AppTheme.silverButtonColor,
                shadowColor: AppTheme.silverShadowColor,
                splashColor: AppTheme.silverHoverColor,
                radius: 15,
                onPressed: () {
                  Navigator.of(context).pop();
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  "QUIT",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              SubmitButton(
                backgroundColor: AppTheme.oButtonColor,
                shadowColor: AppTheme.oShadowColor,
                splashColor: AppTheme.oHoverColor,
                radius: 15,
                onPressed: () {
                  Navigator.of(context).pop();
                  resetGame();
                },
                child: Text(
                  "NEXT ROUND",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
