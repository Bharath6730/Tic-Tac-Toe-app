import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/models/user_model.dart';

class LocalStorageService {
  static final LocalStorageService _storageService =
      LocalStorageService._internal();

  LocalStorageService._internal();

  factory LocalStorageService() {
    return _storageService;
  }

  final _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));
  // late final SharedPreferences _sp;

  // Future initialize() async {
  //   _sp = await SharedPreferences.getInstance();
  //   return Future.value(true);
  // }

  // Future initialize() async {
  //   return Future.value(true);
  // }

  FlutterSecureStorage get getSecureInstance => _secureStorage;

  // SharedPreferences getInstance() {
  //   return _sp;
  // }

  // Future<bool>? setString(String key, String value) {
  //   return _sp.setString(key, value);
  // }

  // Future<bool>? deleteWithKey(String key) {
  //   return _sp.remove(key);
  // }

  // String? getString(String key) {
  //   return _sp.getString(key);
  // }

  // bool? getBool(String key) {
  //   return _sp.getBool(key);
  // }

  Future<bool> getSecuredBool(String key) async {
    var value = await _secureStorage.read(key: key);
    if (value == null) return false;
    return value.toLowerCase() == 'true';
  }

  Future<PersonalData?> getUserData() async {
    String? userName = await _secureStorage.read(key: "userName");
    String? publicId = await _secureStorage.read(key: "publicId");
    String? profilePic = await _secureStorage.read(key: "profilePic");
    String? email = await _secureStorage.read(key: "email");
    String? jwToken = await _secureStorage.read(key: "jwToken");

    if (userName == null ||
        publicId == null ||
        email == null ||
        jwToken == null ||
        profilePic == null) {
      return null;
    }

    return PersonalData(
        email: email,
        token: jwToken,
        name: userName,
        publicId: publicId,
        profilePic: profilePic);
  }

  Future<bool> setUserData(PersonalData myData) async {
    await _secureStorage.write(key: "isLoggedIn", value: "true");
    await _secureStorage.write(key: "userName", value: myData.name);
    await _secureStorage.write(key: "email", value: myData.email);
    await _secureStorage.write(key: "jwToken", value: myData.token);
    await _secureStorage.write(key: "publicId", value: myData.publicId);
    await _secureStorage.write(key: "profilePic", value: myData.profilePic);
    return Future.value(true);
  }
}
