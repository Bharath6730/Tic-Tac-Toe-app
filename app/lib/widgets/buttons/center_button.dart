import 'package:flutter/material.dart';

class CenterButton extends StatelessWidget {
  final String? contentText;
  final Color color;
  final Color shadowColor;
  final Color backgroundColor;
  final double radius;
  final Widget? child;
  final List<double> pad;
  final BoxConstraints? constraints;
  final double? width;

  const CenterButton(
      {Key? key,
      this.contentText,
      required this.color,
      required this.shadowColor,
      required this.backgroundColor,
      required this.radius,
      this.child,
      this.constraints,
      this.width,
      this.pad = const [15, 25]})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      constraints: constraints,
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
      padding: EdgeInsets.symmetric(vertical: pad[0], horizontal: pad[1]),
      child: (child == null)
          ? Text(
              contentText as String,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: color),
              textAlign: TextAlign.center,
            )
          : child,
    );
  }
}
