import 'package:flutter/material.dart';

import 'package:tic_tac_toe/widgets/main_widgets/center_app_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/passAndPlay");
            },
            icon: const Icon(Icons.menu)),
        title: const CenterAppIcon(),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://www.clipartkey.com/mpngs/m/152-1520367_user-profile-default-image-png-clipart-png-download.png",
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text("Hello"),
      ),
    );
  }
}
