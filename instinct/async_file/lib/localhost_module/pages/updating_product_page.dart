import 'dart:io';

import 'package:async_file/localhost_module/logic/product_logic.dart';
import 'package:async_file/localhost_module/widget/Icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../constant/base_url_constant.dart';
import '../logic/image_logic.dart';
import '../models/product_model.dart';
import '../util/message_util.dart';

class UpdatingProductPage extends StatefulWidget {
  final Product item;
  UpdatingProductPage(this.item);

  @override
  State<UpdatingProductPage> createState() => _UpdatingProductPageState();
}

class _UpdatingProductPageState extends State<UpdatingProductPage> {
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
      centerTitle: true,
      backgroundColor: Colors.brown,
      actions: [_buildUpdateButton(), _buildDeleteButton()],
    );
  }

  final _formKey = GlobalKey<FormState>();
  String? _uploadFileName;

  Widget _buildBody() {
    _uploadFileName = context.watch<ImageLogic>().uploadFileName;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            _buildNameTextField(),
            _buildQtyTextField(),
            _buildPriceTextField(),
            _buildOutOfStockCheckBox(),
            _buildImageBrowing(),
            SizedBox(
              height: 20,
            ),
            _buildPhotoFrame(),
          ],
        ),
      ),
    );
  }

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

  Widget _buildPhotoFrame() {
    String fullImageUrl = "$os$port/$folder/${widget.item.image}";
    XFile? xFile = context.watch<ImageLogic>().xFile;

    if (xFile == null) {
      return Container(
        height: 300,
        child: Image.network(fullImageUrl),
      );
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

  Widget _buildDeleteButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(primary: Colors.red),
        onPressed: () async {
          Product item = Product(pid: widget.item.pid);

          bool success = await context.read<ProductLogic>().delete(item);

          if (success == true) {
            await context.read<ProductLogic>().read();
            context.read<ImageLogic>().deletePreviousImage(widget.item.image);
            showSnackBar(context, "Deleted Successfully");
            Navigator.of(context).pop();
          } else {
            showSnackBar(context, "Something Went Wrong");
          }
        },
        icon: Icon(Icons.delete),
        label: Text("Deleted"),
      ),
    );
  }

  late var _nameCtrl = TextEditingController(text: widget.item.name);
  late var _qtyCtrl = TextEditingController(text: widget.item.qty);
  late var _priceCtrl = TextEditingController(text: widget.item.price);
  late var _imageCtrl = TextEditingController(text: widget.item.image);

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

  late bool? _outOfStock = widget.item.outOfStock == "0" ? false : true;
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

  Widget _buildUpdateButton() {
    return IconButton(
      onPressed: () async {
        if (_formKey.currentState!.validate() == true) {
          if (_uploadFileName != null) {
            context.read<ImageLogic>().deletePreviousImage(widget.item.image);
            context.read<ImageLogic>().setImageUploading();
            await context.read<ImageLogic>().uploadFile();
          } else {
            _uploadFileName = widget.item.image;
          }

          Product item = Product(
              pid: widget.item.pid,
              name: _nameCtrl.text.trim(),
              qty: _qtyCtrl.text.trim(),
              price: _priceCtrl.text.trim(),
              image: _uploadFileName!,
              outOfStock: _outOfStock == true ? "1" : "0");
          bool success = await context.read<ProductLogic>().update(item);
          print(success);
          if (success == true) {
            context.read<ProductLogic>().read();
            showSnackBar(context, "Updated Successfully");
            context.read<ImageLogic>().resetXFile();
            Navigator.of(context).pop();
          } else {
            showSnackBar(context, "Something Went Wrong");
          }
        } else {
          showSnackBar(context, "Some Field are not validated");
        }
      },
      icon: Icon(Icons.check),
    );
  }
}

// import 'package:async_file/localhost_module/logic/product_logic.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../models/product_model.dart';
// import '../util/message_util.dart';

// class UpdatingProductPage extends StatefulWidget {
//   final Product item;
//   UpdatingProductPage(this.item);

//   @override
//   State<UpdatingProductPage> createState() => _UpdatingProductPageState();
// }

// class _UpdatingProductPageState extends State<UpdatingProductPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: _buildBody(),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       title: Text("Adding Product Page"),
//       centerTitle: true,
//       backgroundColor: Colors.brown,
//     );
//   }

//   final _formKey = GlobalKey<FormState>();
//   Widget _buildBody() {
//     return Form(
//       key: _formKey,
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: ListView(
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           children: [
//             _buildNameTextField(),
//             _buildQtyTextField(),
//             _buildPriceTextField(),
//             _buildImageTextField(),
//             _buildOutOfStockCheckBox(),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [_buikdButton(), _buildDeleteButton()],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDeleteButton() {
//     return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(primary: Colors.red),
//       onPressed: () async {
//         Product item = Product(pid: widget.item.pid);

//         bool success = await context.read<ProductLogic>().delete(item);

//         if (success == true) {
//           await context.read<ProductLogic>().read();
//           showSnackBar(context, "Deleted Successfully");
//           Navigator.of(context).pop();
//         } else {
//           showSnackBar(context, "Something Went Wrong");
//         }
//       },
//       icon: Icon(Icons.delete),
//       label: Text("Deleted"),
//     );
//   }

//   late var _nameCtrl = TextEditingController(text: widget.item.name);
//   late var _qtyCtrl = TextEditingController(text: widget.item.qty);
//   late var _priceCtrl = TextEditingController(text: widget.item.price);
//   late var _imageCtrl = TextEditingController(text: widget.item.image);

//   Widget _buildNameTextField() {
//     return TextFormField(
//       controller: _nameCtrl,
//       textCapitalization: TextCapitalization.words,
//       decoration: InputDecoration(hintText: "Enter name"),
//       validator: (String? value) {
//         return (value == null || value.isEmpty) ? "Name cannot be empty" : null;
//       },
//     );
//   }

//   Widget _buildQtyTextField() {
//     return TextFormField(
//       controller: _qtyCtrl,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(hintText: "Enter quantity"),
//       validator: (String? value) {
//         return (value == null || value.isEmpty)
//             ? "Quantity cannot be empty"
//             : null;
//       },
//     );
//   }

//   Widget _buildPriceTextField() {
//     return TextFormField(
//       controller: _priceCtrl,
//       keyboardType: TextInputType.numberWithOptions(decimal: true),
//       decoration: InputDecoration(hintText: "Enter price"),
//       validator: (String? value) {
//         return (value == null || value.isEmpty)
//             ? "Price cannot be empty"
//             : null;
//       },
//     );
//   }

//   Widget _buildImageTextField() {
//     return TextFormField(
//       controller: _imageCtrl,
//       decoration: InputDecoration(hintText: "Enter Image Url"),
//       validator: (String? value) {
//         return (value == null || value.isEmpty)
//             ? "Image Url cannot be empty"
//             : null;
//       },
//       maxLines: 5,
//     );
//   }

//   late bool? _outOfStock = widget.item.outOfStock == "0" ? false : true;
//   Widget _buildOutOfStockCheckBox() {
//     return CheckboxListTile(
//       title: Text("Out of Stock"),
//       value: _outOfStock,
//       onChanged: (value) {
//         setState(() {
//           _outOfStock = value;
//         });
//       },
//     );
//   }

//   Widget _buikdButton() {
//     return ElevatedButton.icon(
//       onPressed: () async {
//         if (_formKey.currentState!.validate() == true) {
//           Product item = Product(
//               pid: widget.item.pid,
//               name: _nameCtrl.text.trim(),
//               qty: _qtyCtrl.text.trim(),
//               price: _priceCtrl.text.trim(),
//               image: _imageCtrl.text.trim(),
//               outOfStock: _outOfStock == true ? "1" : "0");
//           bool success = await context.read<ProductLogic>().update(item);

//           if (success == true) {
//             await context.read<ProductLogic>().read();
//             showSnackBar(context, "Updated Successfully");
//             Navigator.of(context).pop();
//           } else {
//             showSnackBar(context, "Something Went Wrong");
//           }
//         } else {
//           showSnackBar(context, "Some fields are not validated");
//         }
//       },
//       icon: Icon(Icons.check),
//       label: Text("UPDATE"),
//     );
//   }
// }
