import 'dart:io';

import 'package:async_file/localhost_module/logic/image_logic.dart';
import 'package:async_file/localhost_module/logic/upload_image_logic.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../widget/Icon_widget.dart';
import 'image_list_page.dart';

class ImageUploadPage extends StatefulWidget {
  ImageUploadPage({Key? key}) : super(key: key);

  @override
  State<ImageUploadPage> createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Image Uploading Page"),
      actions: [
        IconButton(
            onPressed: () {
              context.read<UploadImageLogic>().read();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ImageListPage()));
            },
            icon: Icon(Icons.view_list_rounded)),
        IconButton(
            onPressed: () {
              context.read<ImageLogic>().setImageStatusToNone();
              context.read<ImageLogic>().getImage();
            },
            icon: Icon(Icons.image)),
        IconButton(
            onPressed: () {
              context.read<ImageLogic>().setImageStatusToNone();
              context
                  .read<ImageLogic>()
                  .getImage(imageSource: ImageSource.camera);
            },
            icon: Icon(Icons.camera)),
      ],
    );
  }

  Widget _buildBody() {
    XFile? xFile = context.watch<ImageLogic>().xFile;

    if (xFile == null) {
      return SizedBox();
    } else {
      print("xFile.path: ${xFile.path}");
      return Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Image.file(
                File(xFile.path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                onPressed: () {
                  context.read<ImageLogic>().setImageUploading();
                  context.read<ImageLogic>().uploadFile();
                },
                icon: Icon(
                  Icons.upload_rounded,
                  color: Colors.white54,
                  size: 50,
                ),
              ),
            ),
            _buildLoading(),
          ],
        ),
      );
    }
  }

  Widget _buildLoading() {
    ImageUploadStatus imageUploadStatus =
        context.watch<ImageLogic>().imageUploadStatus;
    switch (imageUploadStatus) {
      case ImageUploadStatus.none:
        return SizedBox();
      case ImageUploadStatus.error:
        return IconWidget(icon: Icon(Icons.error, color: Colors.red));
      case ImageUploadStatus.uploading:
        return Positioned.fill(
          child: Container(
            color: Colors.black12,
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        );
      case ImageUploadStatus.done:
        return IconWidget(
            icon: Icon(
          Icons.check,
          color: Colors.amber,
        ));
    }
  }
}
