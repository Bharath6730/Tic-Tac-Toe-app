// import 'package:flutter/material.dart';
// import 'package:tic_tac_toe/providers/global_provider.dart';
// import 'package:tic_tac_toe/utilities/show_snackbar.dart';
// import 'package:tic_tac_toe/utilities/utlility.dart';
// import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';
// import 'package:tic_tac_toe/widgets/dialogs/dialog_container.dart';

// class EnterANameDialog extends StatelessWidget {
//   const EnterANameDialog({
//     Key? key,
//     required this.formKey,
//     required this.userNameInputController,
//     required this.storage,
//   }) : super(key: key);

//   final GlobalKey<FormState> formKey;
//   final TextEditingController userNameInputController;
//   final GlobalProvider? storage;

//   @override
//   Widget build(BuildContext context) {
//     return DialogContainer(
//         header: Text(
//           "Please Enter Your Name: ",
//           style: Theme.of(context)
//               .textTheme
//               .bodyMedium
//               ?.copyWith(color: Colors.white),
//         ),
//         body: Form(
//           key: formKey,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: TextFormField(
//             validator: (value) {
//               if (value == null || value.isEmpty || value.trim().isEmpty) {
//                 return "Please Enter a name!";
//               }
//               if (value.length > 15) {
//                 return "Name cannot be longer than 15";
//               }
//               if (!value.contains(RegExp(r'^[\w\-\s]+$'))) {
//                 return "Only alphabets, numbers, space or underscore are allowed.";
//               }
//               return null;
//             },
//             controller: userNameInputController,
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 22,
//                 fontWeight: FontWeight.normal),
//             textAlign: TextAlign.center,
//             decoration: const InputDecoration(
//                 contentPadding: EdgeInsets.all(0.0),
//                 hintText: "Enter your name",
//                 hintStyle: TextStyle(color: Colors.white),
//                 focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: AppTheme.silverButtonColor)),
//                 focusColor: AppTheme.oButtonColor,
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white))),
//             textInputAction: TextInputAction.done,
//           ),
//         ),
//         footer: Center(
//           child: SubmitButton(
//             backgroundColor: AppTheme.silverButtonColor,
//             shadowColor: AppTheme.silverShadowColor,
//             splashColor: AppTheme.silverHoverColor,
//             onPressed: () {
//               if (!formKey.currentState!.validate()) {
//                 showSnackBar(context, "Please enter a valid Name");
//                 return;
//               }
//               storage?.setUserName(userNameInputController.text);
//               Navigator.of(context).pop("true");
//             },
//             radius: 10,
//             child: Text(
//               "Save",
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//           ),
//         ));
//   }
// }
