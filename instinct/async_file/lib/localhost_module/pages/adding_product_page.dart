import 'dart:io';

import 'package:async_file/localhost_module/logic/product_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../logic/image_logic.dart';
import '../models/product_model.dart';
import '../util/message_util.dart';
import '../widget/Icon_widget.dart';

class AddingProductPage extends StatefulWidget {
  const AddingProductPage({Key? key}) : super(key: key);

  @override
  State<AddingProductPage> createState() => _AddingProductPageState();
}

class _AddingProductPageState extends State<AddingProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Adding Product Page"),
      actions: [_buildButton()],
      centerTitle: true,
      backgroundColor: Colors.purple,
    );
  }

  String? _uploadFileName;
  final _formKey = GlobalKey<FormState>();
  Widget _buildBody() {
    _uploadFileName = context.watch<ImageLogic>().uploadFileName;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            _buildNameTextField(),
            _buildQtyTextField(),
            _buildPriceTextField(),
            _buildOutOfStockCheckBox(),
            _buildImageBrowing(),
            _buildPhotoFrame()
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoFrame() {
    XFile? xFile = context.watch<ImageLogic>().xFile;

    if (xFile == null) {
      return SizedBox();
    } else {

      return Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 300,
              padding: EdgeInsets.all(10),
              child: Image.file(
                File(xFile.path),
                fit: BoxFit.cover,
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

  var _nameCtrl = TextEditingController();
  var _qtyCtrl = TextEditingController();
  var _priceCtrl = TextEditingController();
  // var _imageCtrl = TextEditingController();
  Widget _buildImageBrowing() {
    return Row(
      children: [
        Text("Select a Photo:"),
        IconButton(
            onPressed: () {
              context.read<ImageLogic>().setImageStatusToNone();
              context.read<ImageLogic>().getImage();
            },
            icon: Icon(
              Icons.image,
              size: 45,
            )),
        IconButton(
            onPressed: () {
              context.read<ImageLogic>().setImageStatusToNone();
              context
                  .read<ImageLogic>()
                  .getImage(imageSource: ImageSource.camera);
            },
            icon: Icon(
              Icons.camera,
              size: 45,
            )),
      ],
    );
  }

  Widget _buildNameTextField() {
    return TextFormField(
      controller: _nameCtrl,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(hintText: "Enter name"),
      validator: (String? value) {
        return (value == null || value.isEmpty) ? "Name cannot be empty" : null;
      },
    );
  }

  Widget _buildQtyTextField() {
    return TextFormField(
      controller: _qtyCtrl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(hintText: "Enter quantity"),
      validator: (String? value) {
        return (value == null || value.isEmpty)
            ? "Quantity cannot be empty"
            : null;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      controller: _priceCtrl,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(hintText: "Enter price"),
      validator: (String? value) {
        return (value == null || value.isEmpty)
            ? "Price cannot be empty"
            : null;
      },
    );
  }



  bool? _outOfStock = false;
  Widget _buildOutOfStockCheckBox() {
    return CheckboxListTile(
      title: Text("Out of Stock"),
      value: _outOfStock,
      onChanged: (value) {
        setState(() {
          _outOfStock = value;
        });
      },
    );
  }

  Widget _buildButton() {
    return IconButton(
      onPressed: () async {
        if (_formKey.currentState!.validate() == true) {
          if (_uploadFileName != null) {
            context.read<ImageLogic>().setImageUploading();
            await context.read<ImageLogic>().uploadFile();
            Product item = Product(
                name: _nameCtrl.text.trim(),
                qty: _qtyCtrl.text.trim(),
                price: _priceCtrl.text.trim(),
                image: _uploadFileName!,
                outOfStock: _outOfStock == true ? "1" : "0");
            bool success = await context.read<ProductLogic>().insert(item);
            print(success);
            if (success == true) {
              showSnackBar(context, "Interted Successfully");
              _nameCtrl.clear();
              _qtyCtrl.clear();
              _priceCtrl.clear();
              context.read<ImageLogic>().resetXFile();
              setState(() {
                _outOfStock = false;
              });
              context.read<ProductLogic>().read();
            } else {
              showSnackBar(context, "Something Went Wrong");
            }
          } else
            showSnackBar(context, "Photo was not selected");
        } else {
          showSnackBar(context, "Some Field are not validated");
        }
      },
      icon: Icon(Icons.check),
    );
  }
}
