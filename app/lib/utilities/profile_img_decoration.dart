import 'package:flutter/material.dart';

const String profileURL =
    "https://res.cloudinary.com/dciwowqk7/image/upload/v1660972618/user/default-profile-pic.jpg";

BoxDecoration profileImageDecoration() {
  return const BoxDecoration(
    shape: BoxShape.circle,
    image: DecorationImage(
      fit: BoxFit.cover,
      image: NetworkImage(profileURL),
    ),
  );
}
