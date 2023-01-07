import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double height;
  final double width;
  final ImageProvider<Object>? imageProvider;

  const ProfileImage(
      {Key? key, required this.height, required this.width, this.imageProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: profileImageDecoration(imageProvider: imageProvider));
  }
}

BoxDecoration profileImageDecoration({imageProvider}) {
  return BoxDecoration(
    shape: BoxShape.circle,
    image: DecorationImage(
      fit: BoxFit.cover,
      image: imageProvider ??
          const AssetImage("assets/images/default-profile-pic.jpg"),
    ),
  );
}
