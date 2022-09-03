import 'package:flutter/material.dart';

import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/center_button.dart';

class GameFooter extends StatelessWidget {
  final int xWinCount;
  final int oWinCount;
  final int tiesCount;
  final String? xCustomName;
  final String? oCustomName;
  const GameFooter({
    Key? key,
    required this.xWinCount,
    required this.oWinCount,
    required this.tiesCount,
    this.oCustomName,
    this.xCustomName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CenterButton(
              contentText: "",
              color: Colors.black,
              shadowColor: AppTheme.xShadowColor,
              backgroundColor: AppTheme.xbuttonColor,
              splashColor: AppTheme.xShadowColor,
              onPressed: () {},
              radius: 15,
              pad: const [10, 15],
              child: FooterButtonLabel(
                type: ButtonType.X,
                score: xWinCount,
                customeName: xCustomName,
              )),
          CenterButton(
              color: Colors.black,
              shadowColor: AppTheme.silverShadowColor,
              backgroundColor: AppTheme.silverButtonColor,
              splashColor: AppTheme.silverHoverColor,
              onPressed: () {},
              radius: 15,
              pad: const [10, 28],
              child: FooterButtonLabel(
                type: ButtonType.none,
                score: tiesCount,
              )),
          CenterButton(
              color: Colors.black,
              shadowColor: AppTheme.oShadowColor,
              backgroundColor: AppTheme.oButtonColor,
              splashColor: AppTheme.oShadowColor,
              onPressed: () {},
              radius: 15,
              pad: const [10, 15],
              child: FooterButtonLabel(
                type: ButtonType.O,
                score: oWinCount,
                customeName: oCustomName,
              )),
        ],
      ),
    );
  }
}

class FooterButtonLabel extends StatelessWidget {
  final int score;
  final ButtonType type;
  final String? customeName;
  const FooterButtonLabel(
      {Key? key, required this.score, required this.type, this.customeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (type != ButtonType.none)
        Row(
          children: [
            Text(
              (customeName != null) ? customeName as String : "Player",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              (customeName != null)
                  ? (type == ButtonType.X)
                      ? "- X"
                      : "- O"
                  : (type == ButtonType.X)
                      ? " X"
                      : " O",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ],
        )
      else
        Text(
          "TIES",
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      const SizedBox(
        height: 4,
      ),
      Text(
        score.toString(),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
            ),
      )
    ]);
  }
}
