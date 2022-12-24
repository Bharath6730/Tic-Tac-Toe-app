import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';

class PlayerSelectionWidget extends StatelessWidget {
  final Function onTap;
  final Player player;
  const PlayerSelectionWidget(
      {Key? key, required this.onTap, required this.player})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: AppTheme.darkShadow,
              offset: Offset(1, 5),
              blurRadius: 0,
            )
          ],
          color: AppTheme.dialogColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "PICK PLAYER 1's MARK:",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 19),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            height: 90,
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppTheme.darkBackground),
            child: Row(
              children: [
                SelectedButton(
                  selected: player == Player.X ? true : false,
                  player: Player.X,
                  onTap: onTap,
                ),
                SelectedButton(
                  selected: player == Player.X ? false : true,
                  player: Player.O,
                  onTap: onTap,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Opacity(
            opacity: 0.5,
            child: Text(
              "REMEMBER : X GOES FIRST",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectedButton extends StatelessWidget {
  final bool selected;
  final Player player;
  final Function onTap;
  const SelectedButton(
      {Key? key,
      required this.selected,
      required this.player,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: () => onTap(player),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 13),
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: selected
                ? AppTheme.silverButtonColor
                : AppTheme.darkBackground),
        child: SvgPicture.asset(
          getAssetLink(player == Player.X ? ButtonType.X : ButtonType.O),
          color:
              selected ? AppTheme.darkBackground : AppTheme.silverButtonColor,
        ),
      ),
    ));
  }
}

// LayoutBuilder(builder: (context, constraints) {
// print("Height:" + constraints.maxHeight.toString());
// print("Width:" + constraints.maxWidth.toString());
// }),
