import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/play_online_provider.dart';
import 'package:tic_tac_toe/providers/play_online_provider_renewed.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';
import 'package:tic_tac_toe/widgets/dialogs/dialog_container.dart';
import 'package:tic_tac_toe/widgets/dialogs/model_widget.dart';

class OnlinePlayWinnerDialog extends StatefulWidget {
  final VoidCallback resetGame;
  final VoidCallback returnFunction;
  final WinnerType winner;
  final String winnerText;
  final PlayOnlineProvider provider;

  const OnlinePlayWinnerDialog(
      {Key? key,
      required this.resetGame,
      required this.returnFunction,
      required this.winner,
      required this.winnerText,
      required this.provider})
      : super(
          key: key,
        );

  @override
  State<OnlinePlayWinnerDialog> createState() => _OnlinePlayModalWidgetState();
}

class _OnlinePlayModalWidgetState extends State<OnlinePlayWinnerDialog>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _top;
  OverlayState? overlayState;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    _top = Tween<double>(begin: 0, end: -70).animate(
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    hideOverlay();
    super.dispose();
  }

  void showOverlay(BuildContext context, GlobalKey key, String opponentName) {
    final RenderBox renderBox =
        key.currentContext?.findRenderObject() as RenderBox;

    final Size size = renderBox.size;

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    overlayState = Overlay.of(context) as OverlayState;
    overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            top: offset.dy + _top.value,
            left: offset.dx,
            child: Opacity(
              opacity: _opacity.value,
              child: Container(
                width: size.width - 20,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: AppTheme.xbuttonColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "$opponentName wants to play again.",
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0.0, -2),
                        child: Transform.rotate(
                          angle: math.pi,
                          child: SvgPicture.asset(
                            "assets/images/triangle2.svg",
                            color: AppTheme.xbuttonColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      )
                    ]),
              ),
            )));

    _controller.addListener(() {
      overlayState?.setState(() {});
    });

    overlayState?.insert(overlayEntry as OverlayEntry);
    _controller.forward();
  }

  void hideOverlay() async {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    Color winColor;
    bool itsADraw = false;

    final GlobalKey key = GlobalKey();

    if (widget.winner != WinnerType.draw) {
      winColor = (widget.winner == WinnerType.X)
          ? AppTheme.xbuttonColor
          : AppTheme.oButtonColor;
    } else {
      itsADraw = true;
      winColor = Colors.red;
    }

    String headerTitle;
    headerTitle = (!itsADraw) ? widget.winnerText : "ITS A TIE!";

    return ChangeNotifierProvider<PlayOnlineProvider>.value(
      value: widget.provider,
      child: DialogContainer(
        header: Text(headerTitle,
            style: const TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.center),
        body: Column(
          children: [
            showWinnerText(
                itsADraw: itsADraw, winColor: winColor, winner: widget.winner),
            const SizedBox(
              height: 30,
            ),
            // TODO : Show Winner Footer here and show profile pics with name during game.
            // Consumer<PlayOnlineProvider>(builder: (_, value, __) {
            //   return GameFooter(
            //     xWinCount: value.xWinCount,
            //     oWinCount: value.oWinCount,
            //     tiesCount: value.tiesCount,
            //     xCustomName: value.iAmPlayer1 ? "You" : value.opponentName,
            //     oCustomName: value.iAmPlayer1 ? value.opponentName : "You",
            //     // onlyName: true,
            //   );
            // }),
          ],
        ),
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            QuitButton(onPressed: () {
              hideOverlay();
              widget.returnFunction();
            }),
            Consumer<PlayOnlineProvider>(builder: (_, value, __) {
              if (value.opponentWantsToPlayAgain) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  showOverlay(context, key, value.opponentDetails.name);
                });
              }
              return NextRoundButton(
                resetGame: () {
                  if (value.opponentWantsToPlayAgain) {
                    hideOverlay();
                  }
                  Navigator.of(context).pop();

                  value.resetGame();
                },
                key: key,
              );
            })
          ],
        ),
      ),
    );
  }
}

class QuitButton extends StatelessWidget {
  final VoidCallback onPressed;
  const QuitButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubmitButton(
      backgroundColor: AppTheme.silverButtonColor,
      shadowColor: AppTheme.silverShadowColor,
      splashColor: AppTheme.silverHoverColor,
      radius: 15,
      onPressed: onPressed,
      child: Text(
        "QUIT",
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class NextRoundButton extends StatelessWidget {
  const NextRoundButton({
    Key? key,
    required this.resetGame,
  }) : super(key: key);

  final VoidCallback resetGame;

  @override
  Widget build(BuildContext context) {
    return SubmitButton(
      backgroundColor: AppTheme.oButtonColor,
      shadowColor: AppTheme.oShadowColor,
      splashColor: AppTheme.oHoverColor,
      radius: 15,
      onPressed: resetGame,
      child: Text(
        "NEXT ROUND",
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}
