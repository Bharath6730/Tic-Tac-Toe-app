import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/models/logic_provider.dart';
import 'package:tic_tac_toe/utilities/dialog_animater.dart';
import 'package:tic_tac_toe/widgets/dialogs/restart_dialog.dart';
import 'package:tic_tac_toe/widgets/main_widgets/center_app_icon.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_footer.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_grid.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_header.dart';
import 'package:tic_tac_toe/widgets/dialogs/model_widget.dart';

Widget buildOfflineGameScreen<T extends LogicProvider>(
    {required BuildContext context, String? playerXName, String? playerOName}) {
  double height = MediaQuery.of(context).size.height;
  return Scaffold(
    appBar: AppBar(
      title: const CenterAppIcon(),
      centerTitle: true,
    ),
    body: Consumer<T>(
      builder: (_, value, __) {
        if (value.showWinnerDialog) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showAnimatedDialog(
              context: context,
              dialog: WinnerDialog(
                resetGame: value.resetGame,
                winner: value.winner,
                winnerText: value.winnerText,
                returnFunction: () {
                  Navigator.of(context).pop("cancel");
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            );
          });
        }
        return Container(
          constraints: BoxConstraints(maxHeight: height - 70),
          child: SizedBox.expand(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.1 > 30 ? 30 : height * 0.1),
                  GameHeader(
                      currentPlayer: value.currentPlayerString,
                      onRefreshClick: () => showAnimatedDialog(
                            context: context,
                            dialog: restartDialog(
                                context: context,
                                restartFunction: value.completeReset),
                          )),
                  GameGrid(xoList: value),
                  GameFooter(
                    xWinCount: value.xWinCount,
                    oWinCount: value.oWinCount,
                    tiesCount: value.tiesCount,
                    xCustomName: playerXName,
                    oCustomName: playerOName,
                  ),
                ]),
          ),
        );
      },
    ),
  );
}
