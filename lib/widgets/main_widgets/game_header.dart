import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/models/utlility.dart';
import 'package:tic_tac_toe/providers/game_provider.dart';
import 'package:tic_tac_toe/widgets/buttons/center_button.dart';
import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Player currentPlayer = Provider.of<GameProvider>(context).playerType;
    String currentPlayerString = (currentPlayer == Player.X) ? "X" : "O";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
          ),
          CenterButton(
            contentText: "$currentPlayerString TURN",
            color: AppTheme.silverButtonColor,
            shadowColor: AppTheme.darkShadow,
            backgroundColor: AppTheme.dialogColor,
            splashColor: AppTheme.darkShadow,
            onPressed: () {},
            radius: 10,
          ),
          const SizedBox(
            width: 10,
          ),
          SubmitButton(
            color: AppTheme.silverButtonColor,
            shadowColor: AppTheme.darkShadow,
            backgroundColor: AppTheme.dialogColor,
            splashColor: AppTheme.darkShadow,
            onPressed: () {},
            radius: 10,
            child: const Center(
              child: Icon(Icons.refresh_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
