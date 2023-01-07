import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/services/socket_service.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/utilities/show_snackbar.dart';
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

  bool showMoreButtons = false;

  void toggleMoreButtons() {
    setState(() {
      showMoreButtons = showMoreButtons ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    SocketConnection socketConnection = Provider.of<SocketConnection>(context);
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
              GameOptionButton(
                  content: "Play Online",
                  color: socketConnection == SocketConnection.connected
                      ? BoxColor.yellow
                      : BoxColor.grey,
                  icon: SvgPicture.asset(
                    "assets/svg/homepage/search.svg",
                    height: 25,
                    width: 30,
                  ),
                  onPressed: () {
                    if (socketConnection != SocketConnection.connected) {
                      return showSnackBar(context,
                          "Unable to connect server.Please try again Later");
                    }
                    Navigator.pushNamed(context, "/playOnline");
                  }),
              const SizedBox(
                height: 10,
              ),
              GameOptionButton(
                  content: "Play a Friend",
                  color: socketConnection == SocketConnection.connected
                      ? BoxColor.yellow
                      : BoxColor.grey,
                  icon: SvgPicture.asset(
                    "assets/svg/homepage/support.svg",
                    height: 25,
                    width: 30,
                  ),
                  onPressed: () {
                    if (socketConnection != SocketConnection.connected) {
                      return showSnackBar(context,
                          "Unable to connect server.Please try again Later");
                    }
                    Navigator.pushNamed(context, "/playOnline");
                  }),
              const SizedBox(
                height: 10,
              ),
              GameOptionButton(
                content: "Vs Computer",
                color: BoxColor.blue,
                icon: SvgPicture.asset(
                  "assets/svg/homepage/robot.svg",
                  height: 25,
                  width: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/playVsCPU",
                      arguments: _selectedPlayer);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GameOptionButton(
                color: BoxColor.dark,
                onPressed: toggleMoreButtons,
                content: "",
                icon: const SizedBox(),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "More",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white54, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Transform.rotate(
                    angle: showMoreButtons ? pi : 0,
                    child: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white54,
                    ),
                  ),
                ]),
              ),
              showMoreButtons
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        GameOptionButton(
                            content: "Pass and Play",
                            color: BoxColor.blue,
                            icon: SvgPicture.asset(
                              "assets/svg/homepage/friends2.svg",
                              height: 25,
                              width: 30,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/passAndPlay",
                                  arguments: _selectedPlayer);
                            }),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    )
                  : const SizedBox()
            ]),
      ),
    );
  }
}

class GameOptionButton extends StatelessWidget {
  final BoxColor color;
  final VoidCallback onPressed;
  final String content;
  final Widget icon;
  final Widget? child;

  const GameOptionButton(
      {Key? key,
      required this.color,
      required this.onPressed,
      required this.content,
      required this.icon,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    bool bigScreen = deviceWidth > 400;
    double width = min(300, deviceWidth * 0.50) + deviceWidth * 0.10;

    return SubmitButton(
      // size: BoxConstraints(minWidth: min(300, width), maxWidth: 500),
      boxColor: color,
      radius: 7,
      onPressed: onPressed,
      child: SizedBox(
        width: width,
        child: (child != null)
            ? child as Widget
            : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: bigScreen ? width * 0.3 : width * 0.2,
                  child: Row(children: [
                    const Expanded(child: SizedBox()),
                    icon,
                    bigScreen
                        ? const SizedBox(
                            width: 30,
                          )
                        : const Expanded(child: SizedBox()),
                  ]),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  content,
                  style: const TextStyle(color: Colors.black87, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Expanded(flex: bigScreen ? 3 : 1, child: const SizedBox())
              ]),
      ),
    );
  }
}
