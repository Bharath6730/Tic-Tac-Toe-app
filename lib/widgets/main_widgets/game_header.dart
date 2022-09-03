import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/center_button.dart';
import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';

class GameHeader extends StatelessWidget {
  final String currentPlayer;
  const GameHeader({Key? key, required this.currentPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Player currentPlayer = Provider.of<PassAndPlayProvider>(context).playerType;
    // String currentPlayerString = (currentPlayer == Player.X) ? "X" : "O";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.25,
          // ),
          CenterButton(
            contentText: "$currentPlayer TURN",
            color: AppTheme.silverButtonColor,
            shadowColor: AppTheme.darkShadow,
            backgroundColor: AppTheme.dialogColor,
            splashColor: AppTheme.darkShadow,
            onPressed: () {},
            radius: 10,
          ),
          // const SizedBox(
          //   width: 10,
          // ),
          // SubmitButton(
          //   color: AppTheme.silverButtonColor,
          //   shadowColor: AppTheme.darkShadow,
          //   backgroundColor: AppTheme.dialogColor,
          //   splashColor: AppTheme.darkShadow,
          //   onPressed: () {},
          //   radius: 10,
          //   child: const Center(
          //     child: Icon(Icons.refresh_rounded),
          //   ),
          // ),
        ],
      ),
    );
  }
}
