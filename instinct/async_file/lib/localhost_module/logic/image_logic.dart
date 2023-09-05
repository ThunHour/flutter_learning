import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import "package:http/http.dart" as http;
import '../constant/base_url_constant.dart';

enum ImageUploadStatus {
  none,
  uploading,
  error,
  done,
}

class ImageLogic extends ChangeNotifier {
  String? _uploadedFilename;
  String? get uploadFileName => _uploadedFilename;
  XFile? _xfile;
  XFile? get xFile => _xfile;
  ImageUploadStatus _imageUploadStatus = ImageUploadStatus.none;
  ImageUploadStatus get imageUploadStatus => _imageUploadStatus;

  void getImage(
      {ImageSource imageSource = ImageSource.gallery,
      double maxHeght = 1080,
      double maxWidth = 1280}) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
        source: imageSource, maxHeight: maxHeght, maxWidth: maxWidth);
    _xfile = file;
    String fileName = _xfile!.path.split("/").last;
    String fileWithFolderName = fileFolder + "/" + fileName;
    _uploadedFilename = fileWithFolderName;
    notifyListeners();
  }

  void setImageStatusToNone() {
    _imageUploadStatus = ImageUploadStatus.none;
    notifyListeners();
  }

  void setImageUploading() {
    _imageUploadStatus = ImageUploadStatus.uploading;
    notifyListeners();
  }

  void resetXFile() {
    _xfile = null;
    _uploadedFilename = null;
    notifyListeners();
  }

  Future<bool> deletePreviousImage(String preImage) async {
    try {
      final url =
          "$os/$folder/deleteImageFromLocal.php?key=a315372a7b98a75426a7af180d19384b72e0ef51&imagePath=$preImage";
      http.Response response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        if (response.body == "Image deleted") {
          return true;
        }
      } else {
        throw Exception("Error while reading data");
      }
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
    return false;
  }

  Future uploadFile() async {
    if (_xfile == null) {
      _imageUploadStatus = ImageUploadStatus.error;
    } else {
      Uint8List byteFile = await _xfile!.readAsBytes();
      String base64Image = await compute(base64Encode, byteFile);
      FormData formData = FormData.fromMap({
        "name": _uploadedFilename,
        "file": MultipartFile.fromString(base64Image),
      });
      try {
        Response response = await Dio().post(fileUploaderUrl, data: formData);
        if (response.statusCode == 200) {
          print("Response.data: ${response.data}");
          if (response.data == "image_inserted") {
            _imageUploadStatus = ImageUploadStatus.done;
          } else {
            _imageUploadStatus = ImageUploadStatus.error;
          }
        } else {
          print("Error while uploading data, code: ${response.statusCode}");
          _imageUploadStatus = ImageUploadStatus.error;
        }
      } catch (e) {
        _imageUploadStatus = ImageUploadStatus.error;
      }
    }
    notifyListeners();
  }
}
