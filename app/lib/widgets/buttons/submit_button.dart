import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';

class SubmitButton extends StatelessWidget {
  final Widget child;
  final Color? shadowColor;
  final Color? backgroundColor;
  final Color? splashColor;
  final VoidCallback onPressed;
  final double radius;
  final BoxConstraints? size;
  final BoxColor? boxColor;
  final double? width;

  const SubmitButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      required this.radius,
      this.shadowColor,
      this.backgroundColor,
      this.splashColor,
      this.size,
      this.width,
      this.boxColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color newShadowColor;
    Color buttonColor;
    Color hoverColor;

    if (shadowColor == null || backgroundColor == null || splashColor == null) {
      switch (boxColor) {
        case BoxColor.blue:
          newShadowColor = AppTheme.xShadowColor;
          buttonColor = AppTheme.xbuttonColor;
          hoverColor = AppTheme.xHoverColor;
          break;
        case BoxColor.yellow:
          newShadowColor = AppTheme.oShadowColor;
          buttonColor = AppTheme.oButtonColor;
          hoverColor = AppTheme.oHoverColor;
          break;
        case BoxColor.grey:
          newShadowColor = Colors.grey.withOpacity(0.8);
          buttonColor = Colors.grey;
          hoverColor = Colors.grey;
          break;
        case BoxColor.dark:
          newShadowColor = AppTheme.darkBackground;
          buttonColor = AppTheme.darkBackground;
          hoverColor = AppTheme.darkBackground;
          break;
        case BoxColor.silver:
          newShadowColor = AppTheme.silverShadowColor;
          buttonColor = AppTheme.silverButtonColor;
          hoverColor = AppTheme.silverHoverColor;
          break;
        case BoxColor.dialog:
          newShadowColor = AppTheme.darkShadow;
          buttonColor = AppTheme.dialogColor;
          hoverColor = AppTheme.darkShadow;
          break;
        default:
          newShadowColor = Colors.grey.withOpacity(0.8);
          buttonColor = Colors.grey;
          hoverColor = Colors.grey;
          break;
      }
    } else {
      newShadowColor = shadowColor as Color;
      buttonColor = backgroundColor as Color;
      hoverColor = splashColor as Color;
    }

    if (boxColor == BoxColor.yellow) {
    } else if (boxColor == BoxColor.grey) {
    } else {}
    return Container(
      constraints: size,
      width: width,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: newShadowColor,
              offset: const Offset(0, 3),
              blurRadius: 1,
            )
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          splashColor: hoverColor,
          onTap: onPressed,
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: child),
        ),
      ),
    );
  }
}
