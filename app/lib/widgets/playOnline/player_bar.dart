import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/center_button.dart';

class PlayerBar extends StatelessWidget {
  final String playerName;
  final int score;
  final Widget image;
  const PlayerBar({
    Key? key,
    required this.playerName,
    required this.score,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(
          maxWidth: 420,
        ),
        padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                image,
                const SizedBox(
                  width: 10,
                ),
                Text(
                  playerName,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                CenterButton(
                  radius: 5,
                  pad: const [10, 15],
                  color: Colors.white70,
                  contentText: score.toString(),
                  shadowColor: AppTheme.darkBackground,
                  backgroundColor: AppTheme.dialogColor,
                ),
                const SizedBox(
                  width: 5,
                )
              ],
            ),
          ],
        ));
  }
}
