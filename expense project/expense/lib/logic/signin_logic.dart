import 'dart:convert';

import 'package:expense/model/signin_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;

class SigninLogic extends ChangeNotifier {
  Future<String> sigin(Signin user) async {
    try {
      String url = "http://10.0.2.2:3000/api/signin";
      http.Response response =
          await http.post(Uri.parse(url), body: user.toMap());
      if (response.statusCode == 200) {
        return json.decode(response.body)['token'];
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }
    return "";
  }

  Future<bool> VerifyUser(String user) async {
    try {
      String url = "http://10.0.2.2:3000/api/checkUser";
      http.Response response =
          await http.post(Uri.parse(url), body: {"u_gmail": user});

      if (response.statusCode == 200) {
        if (json.decode(response.body) == "user no exist") {
          print(response.body);
          return true;
        }
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }
    return false;
  }
}
