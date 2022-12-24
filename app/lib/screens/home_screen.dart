import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/global_provider.dart';
import 'package:tic_tac_toe/utilities/dialog_animater.dart';
import 'package:tic_tac_toe/utilities/show_snackbar.dart';

import 'package:tic_tac_toe/utilities/utlility.dart';

import 'package:tic_tac_toe/utilities/profile_img_decoration.dart';
import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';
import 'package:tic_tac_toe/widgets/dialogs/dialog_container.dart';
import 'package:tic_tac_toe/widgets/homeScreenWidgets/player_selection_widget.dart';
import 'package:tic_tac_toe/widgets/homeScreenWidgets/side_drawer.dart';
import 'package:tic_tac_toe/widgets/main_widgets/center_app_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool userNameInputDialogShown = false;
  Player _selectedPlayer = Player.X;
  void _onTap(Player buttonType) {
    if (buttonType == _selectedPlayer) {
      return;
    }
    setState(() {
      if (_selectedPlayer == Player.X) {
        _selectedPlayer = Player.O;
      } else {
        _selectedPlayer = Player.X;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    LocalStorageProvider? storage = Provider.of<LocalStorageProvider>(context);

    final formKey = GlobalKey<FormState>();

    if (!userNameInputDialogShown && !storage.isUserNameNull()) {
      TextEditingController userNameInputController = TextEditingController();
      userNameInputDialogShown = true;

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showAnimatedDialog(
            dismissable: false,
            context: context,
            dialog: EnterANameDialog(
                formKey: formKey,
                userNameInputController: userNameInputController,
                storage: storage));
        userNameInputDialogShown = false;
        storage.checkUserNameSet();
      });
    }
    return Scaffold(
      drawer: const SideDrawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              margin: const EdgeInsets.only(right: 6),
              width: 40,
              decoration: profileImageDecoration(),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const XOIcon(height: 35),
                const SizedBox(
                  height: 30,
                ),
                PlayerSelectionWidget(
                  onTap: _onTap,
                  player: _selectedPlayer,
                ),
                const SizedBox(
                  height: 40,
                ),
                SubmitButton(
                  size: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.70),
                  shadowColor: AppTheme.oShadowColor,
                  backgroundColor: AppTheme.oButtonColor,
                  splashColor: AppTheme.oHoverColor,
                  radius: 15,
                  onPressed: () {
                    Navigator.pushNamed(context, "/passAndPlay",
                        arguments: _selectedPlayer);
                  },
                  child: Text(
                    "Pass and Play",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SubmitButton(
                  size: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.70),
                  shadowColor: AppTheme.oShadowColor,
                  backgroundColor: AppTheme.oButtonColor,
                  splashColor: AppTheme.oHoverColor,
                  radius: 15,
                  onPressed: () {
                    Navigator.pushNamed(context, "/playVsCPU",
                        arguments: _selectedPlayer);
                  },
                  child: Text(
                    "Play Vs Computer",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SubmitButton(
                  size: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.70),
                  shadowColor: AppTheme.xShadowColor,
                  backgroundColor: AppTheme.xbuttonColor,
                  splashColor: AppTheme.xHoverColor,
                  radius: 15,
                  onPressed: () {
                    Navigator.pushNamed(context, "/playOnline");
                  },
                  child: Text(
                    "Play Online",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

class EnterANameDialog extends StatelessWidget {
  const EnterANameDialog({
    Key? key,
    required this.formKey,
    required this.userNameInputController,
    required this.storage,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController userNameInputController;
  final LocalStorageProvider? storage;

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
        header: Text(
          "Please Enter Your Name: ",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white),
        ),
        body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().isEmpty) {
                return "Please Enter a name!";
              }
              if (value.length > 15) {
                return "Name cannot be longer than 15";
              }
              if (!value.contains(RegExp(r'^[\w\-\s]+$'))) {
                return "Only alphabets, numbers, space or underscore are allowed.";
              }
              return null;
            },
            controller: userNameInputController,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                hintText: "Enter your name",
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.silverButtonColor)),
                focusColor: AppTheme.oButtonColor,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
            textInputAction: TextInputAction.done,
          ),
        ),
        footer: Center(
          child: SubmitButton(
            backgroundColor: AppTheme.silverButtonColor,
            shadowColor: AppTheme.silverShadowColor,
            splashColor: AppTheme.silverHoverColor,
            onPressed: () {
              if (!formKey.currentState!.validate()) {
                showSnackBar(context, "Please enter a valid Name");
                return;
              }
              storage?.setUserName(userNameInputController.text);
              Navigator.of(context).pop("true");
            },
            radius: 10,
            child: Text(
              "Save",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ));
  }
}
