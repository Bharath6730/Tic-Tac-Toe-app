import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/play_online_provider.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';

class CenterContainer extends StatelessWidget {
  final Widget child;
  final double height;
  const CenterContainer({Key? key, required this.child, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).appBarTheme.backgroundColor),
        child: child);
  }
}

class OnlinePlayWelcomeWidget extends StatelessWidget {
  const OnlinePlayWelcomeWidget({
    Key? key,
    required this.roomTextController,
  }) : super(key: key);

  final TextEditingController roomTextController;

  @override
  Widget build(BuildContext context) {
    PlayOnlineProvider provider =
        Provider.of<PlayOnlineProvider>(context, listen: false);
    return Column(children: [
      const SizedBox(
        height: 40,
      ),
      CenterContainer(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
                child: Text("Create Game",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white))),
            Text(
              "Create game and get room code ",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white),
            ),
            SubmitButton(
              shadowColor: AppTheme.xShadowColor,
              backgroundColor: AppTheme.xbuttonColor,
              splashColor: AppTheme.xHoverColor,
              onPressed: provider.createGame,
              radius: 15,
              child: Text("Get Room Code",
                  style: Theme.of(context).textTheme.bodyMedium),
            )
          ],
        ),
      ),
      CenterContainer(
        height: 325,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
                child: Text("Join Game",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white))),
            Text(
              "Join Game with a room Code ",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: roomTextController,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    hintText: "Enter room code",
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.silverButtonColor)),
                    focusColor: AppTheme.oButtonColor,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
                textInputAction: TextInputAction.done,
                onSubmitted: (roomName) => provider.joinGame(roomName),
              ),
            ),
            SubmitButton(
              shadowColor: AppTheme.oShadowColor,
              backgroundColor: AppTheme.oButtonColor,
              splashColor: AppTheme.oHoverColor,
              onPressed: () {
                if (roomTextController.text.isNotEmpty) {
                  provider.joinGame(roomTextController.text);
                }
              },
              radius: 15,
              child: Text("Join Game",
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    ]);
  }
}
