import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/models/user_model.dart';
import 'package:tic_tac_toe/providers/global_provider.dart';
import 'package:tic_tac_toe/providers/play_online_provider.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/utilities/show_snackbar.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';
import 'package:tic_tac_toe/widgets/main_widgets/center_app_icon.dart';

class OnlinePlayWelcomeWidget extends StatefulWidget {
  const OnlinePlayWelcomeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OnlinePlayWelcomeWidget> createState() =>
      _OnlinePlayWelcomeWidgetState();
}

class _OnlinePlayWelcomeWidgetState extends State<OnlinePlayWelcomeWidget> {
  final TextEditingController roomTextController = TextEditingController();

  @override
  void dispose() {
    roomTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PublicUserData myData =
        Provider.of<GlobalProvider>(context).userData!.getPublicData;
    return Scaffold(
      appBar: AppBar(
        title: const CenterAppIcon(),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
          create: (context) =>
              PlayOnlineProvider(context: context, myDetails: myData),
          child: Consumer<PlayOnlineProvider>(builder: (_, provider, __) {
            return WillPopScope(
              onWillPop: () {
                provider.disconnectSocket();
                return Future.value(true);
              },
              child: SingleChildScrollView(
                child: Column(children: [
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
                              ?.copyWith(color: Colors.white54),
                        ),
                        SubmitButton(
                          boxColor: provider.connected
                              ? BoxColor.blue
                              : BoxColor.grey,
                          onPressed: provider.createGame,
                          radius: 8,
                          child: provider.gameState == GameState.creating
                              ? const SizedCircularProgressIndicator()
                              : Text("Get Room Code",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
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
                            child: Text("Join Game: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.white))),
                        Text(
                          "Join Game with a room Code ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white54),
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width * 0.5,
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
                                    borderSide: BorderSide(
                                        color: AppTheme.silverButtonColor)),
                                focusColor: AppTheme.oButtonColor,
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                            textInputAction: TextInputAction.done,
                            onSubmitted: (roomName) =>
                                provider.joinGame(roomName),
                          ),
                        ),
                        SubmitButton(
                          boxColor: provider.connected
                              ? BoxColor.yellow
                              : BoxColor.grey,
                          onPressed: () {
                            if (roomTextController.text.isNotEmpty) {
                              provider.joinGame(roomTextController.text);
                            } else {
                              showSnackBar(context,
                                  "Please enter room code to join game.");
                            }
                          },
                          radius: 8,
                          child: provider.gameState == GameState.joining
                              ? const SizedCircularProgressIndicator()
                              : Row(mainAxisSize: MainAxisSize.min, children: [
                                  const SizedBox(width: 10),
                                  Text(
                                    "Join Game",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(width: 10),
                                ]),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            );
          })),
    );
  }
}

class SizedCircularProgressIndicator extends StatelessWidget {
  const SizedCircularProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 10,
      height: 10,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}

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
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).appBarTheme.backgroundColor),
        child: child);
  }
}
