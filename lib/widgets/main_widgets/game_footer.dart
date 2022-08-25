import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tic_tac_toe/models/utlility.dart';
import 'package:tic_tac_toe/providers/game_provider.dart';
import 'package:tic_tac_toe/widgets/buttons/center_button.dart';

class GameFooter extends StatelessWidget {
  const GameFooter({
    Key? key,
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
              child: Consumer<GameProvider>(
                builder: (_, value, __) {
                  return FooterButtonLabel(
                    type: ButtonType.X,
                    score: value.xWinCount,
                  );
                },
              )),
          CenterButton(
              color: Colors.black,
              shadowColor: AppTheme.silverShadowColor,
              backgroundColor: AppTheme.silverButtonColor,
              splashColor: AppTheme.silverHoverColor,
              onPressed: () {},
              radius: 15,
              pad: const [10, 28],
              child: Consumer<GameProvider>(builder: (_, value, __) {
                return FooterButtonLabel(
                  type: ButtonType.none,
                  score: value.tiesCount,
                );
              })),
          CenterButton(
              color: Colors.black,
              shadowColor: AppTheme.oShadowColor,
              backgroundColor: AppTheme.oButtonColor,
              splashColor: AppTheme.oShadowColor,
              onPressed: () {},
              radius: 15,
              pad: const [10, 15],
              child: Consumer<GameProvider>(builder: (_, value, __) {
                return FooterButtonLabel(
                  type: ButtonType.O,
                  score: value.oWinCount,
                );
              })),
        ],
      ),
    );
  }
}

class FooterButtonLabel extends StatelessWidget {
  final int score;
  final ButtonType type;
  const FooterButtonLabel({Key? key, required this.score, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      (type != ButtonType.none)
          ? Row(
              children: [
                Text(
                  (type == ButtonType.X) ? "X" : "O",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                Text(
                  " Player",
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            )
          : Text(
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
