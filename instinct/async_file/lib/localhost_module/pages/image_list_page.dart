import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/base_url_constant.dart';
import '../constant/enum_product.dart';
import '../logic/product_logic.dart';
import '../logic/upload_image_logic.dart';
import '../models/image_model.dart';

class ImageListPage extends StatefulWidget {
  ImageListPage({Key? key}) : super(key: key);

  @override
  State<ImageListPage> createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Image Page"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    ProductStatus status = context.watch<UploadImageLogic>().status;
    switch (status) {
      case ProductStatus.none:
      case ProductStatus.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      case ProductStatus.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No Internet Connection",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                ),
                onPressed: () {
                  context.read<UploadImageLogic>().setLoading();
                  context.read<UploadImageLogic>().read();
                },
                child: Text("Retry"),
              ),
            ],
          ),
        );
      case ProductStatus.success:
        return _buildListView();
    }
  }

  Widget _buildListView() {
    List<MyImage> items = context.watch<UploadImageLogic>().imageList;
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UploadImageLogic>().setLoading();
        context.read<UploadImageLogic>().read();
      },
      child: GridView.builder(
        padding: EdgeInsets.all(5),
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildItem(items[index]);
        },
      ),
    );
  }

  Widget _buildItem(MyImage item) {
    String fullImageUrl = "$os$port/$folder/${item.imageUrl}";
    print("fullImageUrl :" + fullImageUrl);
    print("item.imageUrl :" + item.imageUrl);
    return Container(
      child: Image.network(
        fullImageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
