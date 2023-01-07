import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/user_model.dart';
import 'package:tic_tac_toe/services/local_storage_service.dart';

class GlobalProvider with ChangeNotifier {
  final LocalStorageService _storageService = LocalStorageService();
  late bool isUserLoggedIn;
  PersonalData? userData;

  Future initialize() async {
    // await _storageService.getSecureInstance.deleteAll();
    isUserLoggedIn = await _storageService.getSecuredBool("isLoggedIn");
    if (isUserLoggedIn) {
      PersonalData? user = await _storageService.getUserData();
      if (user == null) {
        isUserLoggedIn == false;
      } else {
        userData = user;
      }
    }
    return Future.value(true);
  }

  Future<bool> setUserData(PersonalData myData) async {
    await _storageService.setUserData(myData);
    userData = myData;
    print(myData);
    notifyListeners();
    return Future.value(true);
  }
}
