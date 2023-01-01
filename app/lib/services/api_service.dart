import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static Future<http.Response?> loginUser(
      String userNameOrEmail, String password) async {
    try {
      final body = jsonEncode(
          {'emailOrUsername': userNameOrEmail, 'password': password});
      final url = Uri.http("192.168.1.174:3000", "/login");
      var response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      return response;
    } catch (err) {
      return null;
    }
  }
}
