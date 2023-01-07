import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/global_provider.dart';
import 'package:tic_tac_toe/utilities/profile_img.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = Provider.of<GlobalProvider>(context).userData!.name;
    return Drawer(
      backgroundColor: AppTheme.dialogColor,
      child: Column(children: [
        const SizedBox(
          height: 50,
        ),
        const ProfileImage(height: 100, width: 100),
        const SizedBox(
          height: 15,
        ),
        Center(
          child: Text(name,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white)),
        ),
        const SizedBox(
          height: 25,
        ),
        const Divider(
          height: 2,
          thickness: 1,
          color: Colors.white70,
        ),
        const SizedBox(
          height: 10,
        ),
        DrawerItem(onPressed: () {}, title: "Profile"),
        DrawerItem(onPressed: () {}, title: "Stats"),
        const Expanded(
          child: SizedBox(),
        ),
        DrawerItem(
          title: "Settings",
          onPressed: () => Navigator.of(context).pushNamed("/settings"),
        ),
        const SizedBox(
          height: 35,
        ),
      ]),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const DrawerItem({Key? key, required this.onPressed, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        elevation: 100,
        color: AppTheme.darkBackground,
        child: InkWell(
          splashColor: AppTheme.darkShadow,
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white54),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
