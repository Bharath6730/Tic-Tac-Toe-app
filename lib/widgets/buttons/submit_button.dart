import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Widget child;
  final Color shadowColor;
  final Color backgroundColor;
  final Color splashColor;
  final VoidCallback onPressed;
  final double radius;

  const SubmitButton({
    Key? key,
    required this.child,
    required this.shadowColor,
    required this.backgroundColor,
    required this.splashColor,
    required this.onPressed,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(0, 3),
              blurRadius: 1,
            )
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          splashColor: splashColor,
          onTap: onPressed,
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: child),
        ),
      ),
    );
  }
}

          //   child: (contentIcon == null)
          //       ? Text(
          //           content,
          //           style: Theme.of(context)
          //               .textTheme
          //               .bodyMedium
          //               ?.copyWith(color: color),
          //           textAlign: TextAlign.center,
          //         )
          //       : Center(
          //           child: Icon(contentIcon as IconData),
          //         ),
          // ),
