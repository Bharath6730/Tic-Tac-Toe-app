import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/play_vs_cpu_provider.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/widgets/dialogs/pop_with_dialog.dart';
import 'package:tic_tac_toe/widgets/play_screen_helper.dart';

class PlayVsCPUScreen extends StatelessWidget {
  const PlayVsCPUScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Player selectedPlayer =
        ModalRoute.of(context)?.settings.arguments as Player;
    return PopWithDialog(
      child: ChangeNotifierProvider(
          create: (context) => PlayVsCPUProvider(
                player: selectedPlayer,
              ),
          child: buildOfflineGameScreen<PlayVsCPUProvider>(
            context: context,
            playerXName: selectedPlayer == Player.X ? "You" : "CPU",
            playerOName: selectedPlayer == Player.X ? "CPU" : "You",
          )),
    );
  }
}
