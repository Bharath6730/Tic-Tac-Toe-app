// import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageProvider with ChangeNotifier {
  late SharedPreferences _sp;
  String? userName;

  Future<bool>? setUserName(String name) {
    Future<bool>? valueSet = _sp.setString("userName", name);
    userName = name;
    notifyListeners();
    return valueSet;
  }

  bool isUserNameNull() {
    if (userName != null) return true;
    return false;
  }

  bool checkUserNameSet() {
    if (userName != null) return true;
    notifyListeners();
    return false;
  }

  Future initaliaze() async {
    _sp = await SharedPreferences.getInstance();
    userName = _sp.getString("userName");
    return Future.value(true);
  }

  SharedPreferences getInstance() {
    return _sp;
  }

  String? getString(String key) {
    return _sp.getString(key);
  }

  Future<bool>? setString(String key, String value) {
    return _sp.setString(key, value);
  }

  Future<bool>? deleteWithKey(String key) {
    return _sp.remove(key);
  }
}
