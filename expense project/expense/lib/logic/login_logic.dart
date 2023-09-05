import 'dart:convert';

import 'package:expense/model/login_model.dart';
import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;

class LoginLogic extends ChangeNotifier {
  Future<String> login(Login user) async {
    try {
      String url = "http://10.0.2.2:3000/api/login";
      http.Response response =
          await http.post(Uri.parse(url), body: user.toMap());
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {

          return json.decode(response.body)['token'];
        }
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }
    return "";
  }
}

