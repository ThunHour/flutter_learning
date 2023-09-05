import 'package:async_file/localhost_module/logic/image_logic.dart';
import 'package:async_file/localhost_module/logic/product_logic.dart';
import 'package:async_file/localhost_module/pages/updating_product_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/base_url_constant.dart';
import '../constant/enum_product.dart';
import '../models/product_model.dart';
import 'adding_product_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    ProductStatus status = context.watch<ProductLogic>().statue;
    switch (status) {
      case ProductStatus.none:
      case ProductStatus.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      case ProductStatus.error:
        return Center(
          child: Text("Error"),
        );
      case ProductStatus.success:
        return _buildListView();
    }
  }

  Widget _buildListView() {
    List<Product> items = context.read<ProductLogic>().result;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProductLogic>().setLoading();
        context.read<ProductLogic>().read();
      },
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildItem(items[index]);
        },
      ),
    );
  }

  Widget _buildItem(Product item) {
    String fullImageUrl = "$os$port/$folder/${item.image}";
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(fullImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white54,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "${item.price} USD",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        context.read<ImageLogic>().resetXFile();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UpdatingProductPage(item)));
                      },
                    )),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Text(
                  "${item.name}",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "IN STOCK: ${item.qty}",
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Product Page"),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            context.read<ImageLogic>().resetXFile();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddingProductPage()));
          },
          icon: Icon(Icons.add),
        ),
      ],
      backgroundColor: Colors.purple,
    );
  }
}
