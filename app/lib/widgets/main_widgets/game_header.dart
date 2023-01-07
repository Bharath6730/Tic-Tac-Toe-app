import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
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
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Align(
            alignment: Alignment.center,
            child: CenterHeader(currentPlayer: currentPlayer)),
        refreshRequired
            ? Positioned(
                top: 0,
                right: width / 10,
                bottom: 0,
                child: SubmitButton(
                  size: const BoxConstraints(maxWidth: 50),
                  boxColor: BoxColor.dialog,
                  onPressed: onRefreshClick != null
                      ? onRefreshClick as VoidCallback
                      : () {},
                  radius: 10,
                  child: const Center(
                    child: Icon(Icons.refresh_rounded, color: Colors.white),
                  ),
                ),
              )
            : const SizedBox(),
      ],
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
      pad: const [10, 40],
      contentText: "$currentPlayer TURN",
      color: AppTheme.silverButtonColor,
      shadowColor: AppTheme.darkShadow,
      backgroundColor: AppTheme.dialogColor,
      radius: 10,
    );
  }
}
