import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../constant/base_url_constant.dart';

import 'package:http/http.dart' as http;

import '../constant/enum_product.dart';
import '../models/image_model.dart';
import 'product_logic.dart';

class UploadImageLogic extends ChangeNotifier {
  ImageModel _imageModel = ImageModel(images: []);

  ImageModel get imageModel => _imageModel;

  List<MyImage> _imageList = [];

  List<MyImage> get imageList => _imageList;

  ProductStatus _status = ProductStatus.none;

  ProductStatus get status => _status;

  void setLoading() {
    _status = ProductStatus.loading;
    notifyListeners();
  }

  Future read() async {
    try {
      const url = readImageUrl;
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        _imageModel = await compute(_convert, response.body);
        _imageList = _imageModel.images;
        _status = ProductStatus.success;
      } else {
        print(
            "Error while reading images, status code: ${response.statusCode}");
        _status = ProductStatus.error;
      }
    } catch (e) {
      print("Error ${e.toString()}");
      _status = ProductStatus.error;
    }
    notifyListeners();
  }

  // Future<bool> insert(MyImage item) async {
  //   try {
  //     const url = insertUrl;
  //     http.Response response = await http.post(
  //       Uri.parse(url),
  //       body: item.toJson(),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print("response.body: ${response.body}");
  //       if(response.body == "image_inserted"){
  //         return true;
  //       }
  //
  //     } else {
  //       print("Error while inserting image, status code: ${response.statusCode}");
  //       return false;
  //     }
  //   } catch (e) {
  //     print("Error ${e.toString()}");
  //     return false;
  //   }
  //   return false;
  // }

}

ImageModel _convert(String body) {
  return ImageModel.fromJson(json.decode(body));
}
