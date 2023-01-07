import 'package:flutter/material.dart';

class GetAnimatedBody extends StatelessWidget {
  final Widget child;
  final Offset? offset;
  const GetAnimatedBody({Key? key, required this.child, this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 230),
      transitionBuilder: (child, animation) {
        Offset begin = offset ?? const Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      child: child,
    );
  }
}
