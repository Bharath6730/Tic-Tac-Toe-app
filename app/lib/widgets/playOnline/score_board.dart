import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/enums.dart';

import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/center_button.dart';

class ScoreBoard extends StatelessWidget {
  final int xWinCount;
  final int oWinCount;
  final int tiesCount;
  final String playerXName;
  final String playerOName;
  const ScoreBoard({
    Key? key,
    required this.xWinCount,
    required this.oWinCount,
    required this.tiesCount,
    required this.playerOName,
    required this.playerXName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double maxBoxWidth = ((size.width - 40) / 2);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CenterButton(
                    constraints: BoxConstraints(maxWidth: maxBoxWidth),
                    contentText: "",
                    color: Colors.black,
                    shadowColor: AppTheme.dialogColor,
                    backgroundColor: AppTheme.dialogColor,
                    radius: 15,
                    pad: const [8, 2],
                    child: FooterButtonLabel(
                      type: ButtonType.X,
                      score: xWinCount,
                      customeName: playerXName,
                    )),
              ),
              const SizedBox(
                width: 22,
              ),
              Expanded(
                child: CenterButton(
                    constraints: BoxConstraints(maxWidth: maxBoxWidth),
                    color: Colors.black,
                    shadowColor: AppTheme.dialogColor,
                    backgroundColor: AppTheme.dialogColor,
                    radius: 15,
                    pad: const [8, 2],
                    child: FooterButtonLabel(
                      type: ButtonType.O,
                      score: oWinCount,
                      customeName: playerOName,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FooterButtonLabel extends StatelessWidget {
  final int score;
  final ButtonType type;
  final String? customeName;
  const FooterButtonLabel({
    Key? key,
    required this.score,
    required this.type,
    this.customeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name =
        (customeName != null) ? customeName as String : "Player";
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white54,
                fontSize: 22,
                fontWeight: FontWeight.w700),
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          Text(
            " - ",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white54,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              softWrap: false,
              overflow: TextOverflow.clip,
              type == ButtonType.X ? "X" : "O",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white54,
                    fontSize: 22,
                  ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        score.toString(),
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white54, fontSize: 20),
      ),
    ]);
  }
}
