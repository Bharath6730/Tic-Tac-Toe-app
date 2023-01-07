import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/enums.dart';

import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/center_button.dart';

class GameFooter extends StatelessWidget {
  final int xWinCount;
  final int oWinCount;
  final int tiesCount;
  final String? xCustomName;
  final String? oCustomName;
  final bool onlyName;
  const GameFooter(
      {Key? key,
      required this.xWinCount,
      required this.oWinCount,
      required this.tiesCount,
      this.oCustomName,
      this.xCustomName,
      this.onlyName = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double maxBoxWidth = ((size.width - 40) / 3);
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CenterButton(
                  constraints: BoxConstraints(maxWidth: maxBoxWidth),
                  contentText: "",
                  color: Colors.black,
                  shadowColor: AppTheme.xShadowColor,
                  backgroundColor: AppTheme.xbuttonColor,
                  radius: 12,
                  pad: const [10, 5],
                  child: FooterButtonLabel(
                    type: ButtonType.X,
                    score: xWinCount,
                    customeName: xCustomName,
                    onlyName: onlyName,
                  )),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: CenterButton(
                  constraints: BoxConstraints(maxWidth: maxBoxWidth),
                  color: Colors.black,
                  shadowColor: AppTheme.silverShadowColor,
                  backgroundColor: AppTheme.silverButtonColor,
                  radius: 12,
                  pad: const [10, 20],
                  child: FooterButtonLabel(
                    type: ButtonType.none,
                    score: tiesCount,
                    onlyName: onlyName,
                  )),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: CenterButton(
                  constraints: BoxConstraints(maxWidth: maxBoxWidth),
                  color: Colors.black,
                  shadowColor: AppTheme.oShadowColor,
                  backgroundColor: AppTheme.oButtonColor,
                  radius: 12,
                  pad: const [10, 5],
                  child: FooterButtonLabel(
                    type: ButtonType.O,
                    score: oWinCount,
                    customeName: oCustomName,
                    onlyName: onlyName,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class FooterButtonLabel extends StatelessWidget {
  final int score;
  final ButtonType type;
  final String? customeName;
  final bool onlyName;
  const FooterButtonLabel(
      {Key? key,
      required this.score,
      required this.type,
      this.customeName,
      required this.onlyName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name =
        (customeName != null) ? customeName as String : "Player";
    final String playerType = (type == ButtonType.X) ? " - X" : " - O";

    return Column(children: [
      if (type != ButtonType.none)
        (!onlyName)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.visible,
                      softWrap: false,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      softWrap: false,
                      overflow: TextOverflow.clip,
                      playerType,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  // Text(
                  //   overflow: TextOverflow.visible,
                  //   "Player $playerType",
                  //   style: Theme.of(context).textTheme.bodySmall,
                  // ),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
      else
        Text(
          "Ties",
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
      ),
    ]);
  }
}
