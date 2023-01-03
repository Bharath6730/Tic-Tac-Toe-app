import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/models/user_model.dart';
import 'package:tic_tac_toe/providers/global_provider.dart';
import 'package:tic_tac_toe/services/api_service.dart';
import 'package:tic_tac_toe/utilities/show_snackbar.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateToHomeScreen() {
      Navigator.pushNamed(context, "/home");
    }

    GlobalProvider provider =
        Provider.of<GlobalProvider>(context, listen: false);
    showSnackBarHere(text) => showSnackBar(context, text);
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          TextFormField(
            // validator: nameValidator,
            validator: (value) {
              return null;
            },
            controller: userNameController,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                hintText: "Enter your email",
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.silverButtonColor)),
                focusColor: AppTheme.oButtonColor,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            validator: (data) {
              return null;
            },
            controller: passwordController,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                hintText: "Enter your Password",
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.silverButtonColor)),
                focusColor: AppTheme.oButtonColor,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
            textInputAction: TextInputAction.done,
          ),
        ]),
      ),
      const SizedBox(
        height: 40,
      ),
      Center(
        child: SubmitButton(
          backgroundColor: AppTheme.silverButtonColor,
          shadowColor: AppTheme.silverShadowColor,
          splashColor: AppTheme.silverHoverColor,
          onPressed: () async {
            if (!formKey.currentState!.validate()) {
              showSnackBar(context, "Please enter a valid Name");
              return;
            }
            var response = await ApiService.loginUser(
                userNameController.text, passwordController.text);
            if (response == null) {
              return showSnackBarHere(
                  "There was an error. Please try again Later");
            }

            if (response.statusCode != 200) {
              showSnackBarHere(response.body);
              return;
            }
            Map<String, dynamic> responseBody = jsonDecode(response.body);

            PersonalData myData = PersonalData.fromJson(
                Map<String, String>.from(responseBody['data']));
            await provider.setUserData(myData);
            navigateToHomeScreen();
          },
          radius: 10,
          child: Text(
            "Login",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      )
    ]));
  }
}

String? nameValidator(String? value) {
  if (value == null || value.isEmpty || value.trim().isEmpty) {
    return "Please Enter a name!";
  }
  if (value.length > 20) {
    return "Name cannot be longer than 20";
  }
  if (!value.contains(RegExp(r'^[A-Za-z0-9-_\s]+$'))) {
    return "Only alphabets, numbers, space or underscore are allowed.";
  }
  return null;
}
