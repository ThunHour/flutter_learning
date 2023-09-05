import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter/foundation.dart';

import '../model/photo_model.dart';

class PhotoHelper {
  static Future<List<Photomodel>> readData() async {
    String url = "https://jsonplaceholder.typicode.com/photos";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return compute(_convert, response.body);
    } else {
      throw Exception("Error while reading data");
    }
  }
}

List<Photomodel> _convert(String body) {
  List list = json.decode(body);
  return list.map((item) => Photomodel.hour(item)).toList();
}
