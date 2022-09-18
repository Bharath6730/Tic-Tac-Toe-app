import 'package:flutter/material.dart';

import 'package:tic_tac_toe/utilities/utlility.dart';

import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';
import 'package:tic_tac_toe/widgets/homeScreenWidgets/player_selection_widget.dart';
import 'package:tic_tac_toe/widgets/main_widgets/center_app_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              margin: const EdgeInsets.only(right: 6),
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://www.clipartkey.com/mpngs/m/152-1520367_user-profile-default-image-png-clipart-png-download.png",
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
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
