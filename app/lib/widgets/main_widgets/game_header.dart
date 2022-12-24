import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/center_button.dart';
import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';

class GameHeader extends StatelessWidget {
  final String currentPlayer;
  final bool refreshRequired;
  final VoidCallback? onRefreshClick;
  const GameHeader(
      {Key? key,
      required this.currentPlayer,
      this.onRefreshClick,
      this.refreshRequired = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
          ),
          CenterHeader(currentPlayer: currentPlayer),
          const SizedBox(
            width: 10,
          ),
          refreshRequired
              ? SubmitButton(
                  shadowColor: AppTheme.darkShadow,
                  backgroundColor: AppTheme.dialogColor,
                  splashColor: AppTheme.darkShadow,
                  onPressed: onRefreshClick != null
                      ? onRefreshClick as VoidCallback
                      : () {},
                  radius: 10,
                  child: const Center(
                    child: Icon(Icons.refresh_rounded, color: Colors.white),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class CenterHeader extends StatelessWidget {
  const CenterHeader({
    Key? key,
    required this.currentPlayer,
  }) : super(key: key);

  final String currentPlayer;

  @override
  Widget build(BuildContext context) {
    return CenterButton(
      contentText: "$currentPlayer TURN",
      color: AppTheme.silverButtonColor,
      shadowColor: AppTheme.darkShadow,
      backgroundColor: AppTheme.dialogColor,
      splashColor: AppTheme.darkShadow,
      onPressed: () {},
      radius: 10,
    );
  }
}
