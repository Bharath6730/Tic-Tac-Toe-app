import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/pass_and_play_provider.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/widgets/dialogs/pop_with_dialog.dart';
import 'package:tic_tac_toe/widgets/play_screen_helper.dart';

class PassAndPlayScreen extends StatelessWidget {
  const PassAndPlayScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Player player = ModalRoute.of(context)?.settings.arguments as Player;
    return PopWithDialog(
      child: ChangeNotifierProvider(
          create: (context) => PassAndPlayProvider(
                playerType: player,
              ),
          child: buildOfflineGameScreen<PassAndPlayProvider>(
            context: context,
          )),
    );
  }
}
