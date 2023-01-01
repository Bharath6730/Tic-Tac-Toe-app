import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';
import 'package:tic_tac_toe/widgets/home_screen_widgets/player_selection_widget.dart';
import 'package:tic_tac_toe/widgets/main_widgets/center_app_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Player _selectedPlayer = Player.X;
  void _onTap(Player buttonType) {
    if (buttonType == _selectedPlayer) {
      return;
    }
    setState(() {
      if (_selectedPlayer == Player.X) {
        _selectedPlayer = Player.O;
      } else {
        _selectedPlayer = Player.X;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const XOIcon(height: 35),
              const SizedBox(
                height: 30,
              ),
              PlayerSelectionWidget(
                onTap: _onTap,
                player: _selectedPlayer,
              ),
              const SizedBox(
                height: 40,
              ),
              SubmitButton(
                size: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.70),
                shadowColor: AppTheme.oShadowColor,
                backgroundColor: AppTheme.oButtonColor,
                splashColor: AppTheme.oHoverColor,
                radius: 15,
                onPressed: () {
                  Navigator.pushNamed(context, "/passAndPlay",
                      arguments: _selectedPlayer);
                },
                child: Text(
                  "Pass and Play",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SubmitButton(
                size: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.70),
                shadowColor: AppTheme.oShadowColor,
                backgroundColor: AppTheme.oButtonColor,
                splashColor: AppTheme.oHoverColor,
                radius: 15,
                onPressed: () {
                  Navigator.pushNamed(context, "/playVsCPU",
                      arguments: _selectedPlayer);
                },
                child: Text(
                  "Play Vs Computer",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SubmitButton(
                size: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.70),
                shadowColor: AppTheme.xShadowColor,
                backgroundColor: AppTheme.xbuttonColor,
                splashColor: AppTheme.xHoverColor,
                radius: 15,
                onPressed: () {
                  Navigator.pushNamed(context, "/playOnline");
                },
                child: Text(
                  "Play Online",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              )
            ]),
      ),
    );
  }
}
